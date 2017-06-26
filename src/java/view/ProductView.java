package view;

// classes imported from java.sql.*
import java.sql.PreparedStatement;
import java.sql.ResultSet;

// classes in my project
import dbUtils.DbConn;
import dbUtils.FormatUtils;

public class ProductView {

    /* This method returns a HTML table displaying all the records of the web_user table. 
     * cssClassForResultSetTable: the name of a CSS style that will be applied to the HTML table.
     *   (This style should be defined in the JSP page (header or style sheet referenced by the page).
     * dbc: an open database connection.
     */
    public static String listAllProducts(String cssClassForResultSetTable,
            String updateFn, String updateIcon, String delFn, String delIcon, DbConn dbc) {

        // Prepare some HTML that will be used repeatedly for the update icon that
        // calls an update javascript function (see below).
        if ((updateIcon == null) || (updateIcon.length() == 0)) {
            return "Product.listUpdateProducts() error: update Icon file name (String input parameter) is null or empty.";
        }
        if ((updateFn == null) || (updateFn.length() == 0)) {
            return "Product.listUpdateProducts() error: update javascript function name (String input parameter) is null or empty.";
        }

        // Prepare some HTML that will be used repeatedly for the delete icon that
        // calls a delete javascript function (see below).
        if ((delIcon == null) || (delIcon.length() == 0)) {
            return "ProductSql.listAllProducts() error: delete Icon file name (String input parameter) is null or empty.";
        }
        if ((delFn == null) || (delFn.length() == 0)) {
            return "ProductSql.listAllProducts() error: delete javascript function name (String input parameter) is null or empty.";
        }

        // This is the first half of the HTML that defines a table cell that will hold the update
        // icon which will be linked to a javascript function for updating the current row.
        String updateStart = "<td style='border:none; background-color:transparent; text-align:center;'><a href='" + updateFn + "(";
        // This is the HTML for the second half of that same HTML
        // In between the first half and the second half will be the actual PK of the current row
        // (input parameter to the javascript function).
        String updateEnd = ")'><img src='" + updateIcon + "'></a></td>"; // after PK value/input parameter to js fn.

        // This is the first half of the HTML that defines a table cell that will hold the delete
        // icon which will be linked to a javascript function for deleting the current row.
        String delStart = "<td style='border:none; text-align:center; background-color:transparent;'><a href='" + delFn + "(";
        // This is the HTML for the second half of that same HTML
        // In between the first half and the second half will be the actual PK of the current row
        // (input parameter to the javascript function).
        String delEnd = ")'><img src='" + delIcon + "'></a></td>"; // after PK value/input parameter to js fn.

        // use StringBuilder object instead of plain String because it is more efficient
        // (with all the appending that we are doing here).
        StringBuilder sb = new StringBuilder("");

        PreparedStatement stmt = null;
        ResultSet rst = null;
        try {
            //sb.append("ready to create the statement & execute query " + "<br/>");
            String sql = "select product_id, product_name, product_desc, product_price  "
                    + " from product order by product_name";
            stmt = dbc.getConn().prepareStatement(sql);
            rst = stmt.executeQuery();
            //sb.append("executed the query " + "<br/><br/>");
            sb.append("<table class='" + cssClassForResultSetTable + "'>");
            sb.append("<tr>");
            sb.append("<th>Update</th>");// extra column at left for update icon
            sb.append("<th>Delete</th>");// extra column at left for delete icon
            sb.append("<th>Product ID</th>");
            sb.append("<th>Product Name</th>");
            sb.append("<th>Product Description</th>");
            sb.append("<th>Product Price</th>");
            sb.append("</tr>");

            while (rst.next()) {
                // Extract the fields from the (current row of the) result set
                // in order (1, 2, 3,...) and don't try to extract the same 
                // field more than once.  
                // Think of the result set like a sequential text file, where you can only
                // read elements in order and you cannot read the same element twice.

                // since we want to use the primary key value several times, 
                // save this object so we reuse it.
                Object primaryKeyObj = rst.getObject(1);
                Integer primaryKeyInt = (Integer) primaryKeyObj;
                sb.append("<tr>");

                // this is the column with an update icon that has a link to a javascript function.
                // the input parameter to the delete javascript function is the PK of the user in this row.
                sb.append(updateStart + primaryKeyInt.toString() + updateEnd);

                // this is the column with a delete icon that has a link to a javascript function.
                // the input parameter to the delete javascript function is the PK of the user in this row.
                sb.append(delStart + primaryKeyInt.toString() + delEnd);

                sb.append(FormatUtils.formatIntegerTd(primaryKeyObj));
                sb.append(FormatUtils.formatStringTd(rst.getObject(2)));
                sb.append(FormatUtils.formatStringTd(rst.getObject(3)));
                sb.append(FormatUtils.formatDollarTd(rst.getObject(4)));
                sb.append("</tr>\n");
            }
            sb.append("</table>");
            rst.close();
            stmt.close();
            return sb.toString();
        } catch (Exception e) {
            return "Exception thrown in Product.listAllProducts(): " + e.getMessage()
                    + "<br/> partial output: <br/>" + sb.toString();
        }
    }
}
