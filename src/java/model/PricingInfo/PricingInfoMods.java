package model.PricingInfo;

import java.sql.*;
import dbUtils.*;

public class PricingInfoMods {

    private DbConn dbc;  // Open, live database connection
    private String errorMsg = "";
    private String debugMsg = "";

    // all methods of this class require an open database connection.
    public PricingInfoMods(DbConn dbc) {
        this.dbc = dbc;
    }

    public String getDebugMsg() {
        return this.debugMsg;
    }

    public String getErrorMsg() {
        return this.errorMsg;
    }

    /* returns "" if all went well, otherwise returns error message */
    public String delete(String primaryKey) {
        this.errorMsg = "";  // clear any error message from before.
        
        String sql = "DELETE FROM pricing_info where pricing_info_id=?";
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
            System.out.println(this.errorMsg);
            //e.printStackTrace();
            return this.errorMsg;
        } // catch
        catch (Exception e) {
            this.errorMsg = "General Error in InfoSql.delete: "
                    + e.getMessage();
            System.out.println(this.errorMsg);
            //e.printStackTrace();
            return this.errorMsg;
        } // catch
    }// method delete
} // class