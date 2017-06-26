package model.Product;

import java.sql.*;
import dbUtils.*;

/**
 * This class contains all code that modifies records in a table in the
 * database. So, Insert, Update, and Delete code will be in this class
 * (eventually). Right now, it's just doing DELETE.
 *
 * This class requires an open database connection for its constructor method.
 */
public class ProductMods {

    private DbConn dbc;  // Open, live database connection
    private String errorMsg = "";
    private String debugMsg = "";

    // all methods of this class require an open database connection.
    public ProductMods(DbConn dbc) {
        this.dbc = dbc;
    }

    public String getDebugMsg() {
        return this.debugMsg;
    }

    public String getErrorMsg() {
        return this.errorMsg;
    }

    public String insert(Validate wuValidate) {

        this.errorMsg = "";// empty error message means it worked.
        this.debugMsg = "";

        // dont even try to insert if the user data didnt pass validation.
        if (!wuValidate.isValidated()) {
            this.errorMsg = "Cannot insert due to validation errors. Please try again.";
            return this.errorMsg;
        }

        TypedData wuTypedData = (TypedData) wuValidate.getTypedData();
        String sql = "INSERT INTO product (product_name, product_desc, product_price"
                + ") VALUES (?,?,?)";
        try {
            // This is Sally's wrapper class for java.sql.PreparedStatement
            PrepStatement pStat = new PrepStatement(dbc, sql);
            pStat.setString(1, wuTypedData.getProductName());
            pStat.setString(2, wuTypedData.getProductDesc());
            pStat.setBigDecimal(3, wuTypedData.getProductPrice());
            this.errorMsg = pStat.getAllErrors();
            if (this.errorMsg.length() != 0) {
                return this.errorMsg;
            }

            //System.out.println("************* got past encoding");
            try {
                // extract the real java.sql.PreparedStatement from Sally's wrapper class.
                int numRows = pStat.getPreparedStatement().executeUpdate();
                if (numRows == 1) {
                    return ""; // all is GOOD, one record inserted is what we expect
                } else {
                    this.errorMsg = "Error: " + new Integer(numRows).toString()
                            + " records were inserted where only 1 expected."; // probably never get here, would be bulk sql insert
                    return this.errorMsg;
                }
            } // try execute the statement
            catch (SQLException e) {
                if (e.getSQLState().equalsIgnoreCase("S1000")) {
                    // this error would only be possible for a non-auto-increment primary key.
                    this.errorMsg = "Cannot insert: a record with that ID already exists.";
                } else if (e.getMessage().toLowerCase().contains("duplicate entry")) {
                    this.errorMsg = "Cannot insert: duplicate entry."; // for example a unique key constraint.
                } else {
                    this.errorMsg = "Product.insert: SQL Exception while attempting insert. "
                            + "SQLState:" + e.getSQLState()
                            + ", Error message: " + e.getMessage();
                    // this message would show up in the NetBeans log window (below the editor)
                    System.out.println("************* " + this.errorMsg);
                }
                return this.errorMsg;
            } // catch
            catch (Exception e) {
                // this message would show up in the NetBeans log window (below the editor)
                this.errorMsg = "ProductMods.insert: General Error while attempting the insert. " + e.getMessage();
                System.out.println("****************** " + this.errorMsg);
                return this.errorMsg;
            } // catch
        } // trying to prepare the statement
        catch (Exception e) {
            this.errorMsg = "ProductMods.insert: General Error while trying to prepare the SQL INSERT statement. " + e.getMessage();
            System.out.println("****************** " + this.errorMsg);
            return this.errorMsg;
        }
    }// method

    public StringData findKey(String primaryKey) {

        this.errorMsg = "";  // clear any error message from before.
        try {
            String sql = "SELECT * FROM product where product_id=?";
            PreparedStatement sqlSt = dbc.getConn().prepareStatement(sql);
            sqlSt.setString(1, primaryKey);

            try {
                ResultSet results = sqlSt.executeQuery(); // expecting only one row in result set
                StringData stringData = this.extractResultSetToStringData(results);//

                if (stringData != null) {
                    System.out.println("*** ProductMods.find: Product (found or not found) is " + stringData.toString());
                    return stringData; // if stringData is full, record found. else all fields will be blank "".
                } else { // stringData null means there was a problem extracting data
                    // check the System.out message in the log to see exact exception error msg.
                    return null;
                }
            } catch (Exception e) {
                this.errorMsg = e.getMessage();
                System.out.println("*** ProductMods.find: exception thrown running Select Statement " + primaryKey
                        + ". Error is: " + this.errorMsg);
                return null;
            }
        }// try
        catch (Exception e) {
            this.errorMsg = e.getMessage();
            System.out.println("*** ProductMods.find: exception thrown Preparing Select Statement with PK " + primaryKey
                    + ". Error is: " + this.errorMsg);
            return null;
        }
    } // method

    public StringData extractResultSetToStringData(ResultSet results) {
        StringData wuStringData = new StringData();
        try {
            if (results.next()) { // we are expecting only one rec in result set, so while loop not needed.
                //select product_id, product_name, product_desc, product_price from product

                wuStringData.productId = FormatUtils.objectToString(results.getObject("product_id"));
                wuStringData.productName = FormatUtils.objectToString(results.getObject("product_name"));
                wuStringData.productDesc = FormatUtils.objectToString(results.getObject("product_desc"));
                wuStringData.productPrice = FormatUtils.objectToString(results.getObject("product_price"));
                wuStringData.recordStatus = "Record Found";

                System.out.println("*** ProductMods.extractResultSetToStringData: record values are "
                        + wuStringData.toString());

                return wuStringData; // means OK, record found and wu has been filled
            } else {
                wuStringData.recordStatus = "Record Not Found";
                return wuStringData; // not found, all fields will be blank
            }
        } catch (Exception e) {
            System.out.println("*** ProductMods.extractResultSetToStringData() Exception: " + e.getMessage());
            return null;
        } // catch misc error
    } // method    

    // Returning "" empty string means the UPDATE was successful
    public String update(Validate validate) {
        this.errorMsg = "";

        // dont even try to insert if the user data didnt pass validation.
        if (!validate.isValidated()) {
            this.errorMsg = "Please edit record and resubmit";
            return this.errorMsg;
        }

        TypedData wuTypedData = (TypedData) validate.getTypedData();
        String sql = "UPDATE product SET product_name=? "
                + ", product_desc=?, product_price=?  "
                + "where product_id = ?";

        try {

            // This is Sally's wrapper class for java.sql.PreparedStatement
            PrepStatement pStat = new PrepStatement(dbc, sql);
            pStat.setString(1, wuTypedData.getProductName());
            pStat.setString(2, wuTypedData.getProductDesc());
            pStat.setBigDecimal(3, wuTypedData.getProductPrice());
            pStat.setInt(4, wuTypedData.getProductId());
            this.errorMsg = pStat.getAllErrors();
            if (this.errorMsg.length() != 0) {
                return this.errorMsg;
            }

            //System.out.println("******* Trying to update Product with id: ["+ wu.getIdProduct() + "]");
            try {
                int numRows = pStat.getPreparedStatement().executeUpdate();
                if (numRows == 1) {
                    this.errorMsg = "";
                    return this.errorMsg; // all is GOOD, one record was updated like we expected.
                } else {
                    // we could be here (numRows==0) if record was not found.
                    // we could be here (numRows>1) if we forgot where clause -- would update all recs.
                    // In either case, it would probalby be a programmer error.
                    this.errorMsg = "Error: " + new Integer(numRows).toString()
                            + " records were updated (when only 1 record expected for update).";
                    return this.errorMsg;
                }
            } // try
            catch (SQLException e) {
                if (e.getSQLState().equalsIgnoreCase("S1000")) {
                    // this error would only be possible for a non-auto-increment primary key.
                    this.errorMsg = "Cannot update: a record with that ID already exists.";
                } else if (e.getMessage().toLowerCase().contains("duplicate entry")) {
                    this.errorMsg = "Cannot update: duplicate entry."; // for example a unique key constraint.
                } else {
                    this.errorMsg = "Product.update: SQL Exception while attempting update. "
                            + "SQLState:" + e.getSQLState()
                            + ", Error message: " + e.getMessage();
                    // this message would show up in the NetBeans log window (below the editor)
                    System.out.println("************* " + this.errorMsg);
                }
                return this.errorMsg;
            } // catch
            catch (Exception e) {
                this.errorMsg = "ProductMods.update: General Exception during update operation. "
                        + e.getMessage();
                System.out.println(this.errorMsg);
                //e.printStackTrace();
                return this.errorMsg;
            } // catch
        } // try
        catch (Exception e) {
            this.errorMsg = "ProductMods.update: Problem preparing statement (and/or substituting parameters). "
                    + e.getMessage();
            System.out.println(this.errorMsg);
            //e.printStackTrace();
            return this.errorMsg;
        } // catch
    }// method
    
    public String delete(String primaryKey) {
        this.errorMsg = "";  // clear any error message from before.
        
        String sql = "DELETE FROM product where product_id=?";
        try {
            PreparedStatement sqlSt = dbc.getConn().prepareStatement(sql);
            sqlSt.setString(1, primaryKey);

            int numRows = sqlSt.executeUpdate();
            if (numRows == 1) {
                this.errorMsg = "";
                return this.errorMsg; // all is GOOD
            } else {
                this.errorMsg = "Error - " + new Integer(numRows).toString()
                        + " records deleted (1 was expected)."; // probably never get here
                return this.errorMsg;
            }
        } // try
        catch (SQLException e) {
            this.errorMsg = "";
            if (e.getSQLState().equalsIgnoreCase("S1000")) {
                this.errorMsg = "Could not delete.";
            }
            if (e.getMessage().toLowerCase().contains("foreign key")) {
                this.errorMsg = "You cannot delete this Product because it have purchases.";
            }
            System.out.println(this.errorMsg);
            //e.printStackTrace();
            return this.errorMsg;
        } // catch
        catch (Exception e) {
            this.errorMsg = "General Error in ProductSql.delete: "
                    + e.getMessage();
            System.out.println(this.errorMsg);
            //e.printStackTrace();
            return this.errorMsg;
        } // catch
    }// method delete
} // class
