package view;

// classes imported from java.sql.*
import java.sql.PreparedStatement;
import java.sql.ResultSet;

// classes in my project
import dbUtils.DbConn;
import dbUtils.FormatUtils;

public class PricingInfoView {

    /* This method returns a HTML table displaying all the records of the pricing_info table. 
     * cssClassForResultSetTable: the name of a CSS style that will be applied to the HTML table.
     *   (This style should be defined in the JSP page (header or style sheet referenced by the page).
     * dbc: an open database connection.
     */
    public static String listAllInfo(String cssClassForResultSetTable, DbConn dbc) {
        // use StringBuilder object instead of plain String because it is more efficient
        // (with all the appending that we are doing here).
        StringBuilder sb = new StringBuilder("");

        PreparedStatement stmt = null;
        ResultSet rst = null;
        try {
            //sb.append("ready to create the statement & execute query " + "<br/>");
            String sql = "SELECT product_name, pricing_info, dis_rate, user_email, phone "
                    + "FROM pricing_info, product, web_user "
                    + "WHERE pricing_info.product_id = product.product_id AND pricing_info.web_user_id = web_user.web_user_id "
                    + "ORDER BY product_name";
            stmt = dbc.getConn().prepareStatement(sql);
            rst = stmt.executeQuery();
            //sb.append("executed the query " + "<br/><br/>");

            sb.append("<table class='" + cssClassForResultSetTable + "'>");
            sb.append("<tr>");
            sb.append("<th>Product Name</th>");
            sb.append("<th>Pricing Info</th>");
            sb.append("<th>Discount Rate</th>");
            sb.append("<th>User Email</th>");
            sb.append("<th>Phone Number</th>");
            sb.append("</tr>");

            while (rst.next()) {
                // I'm pretty sure that you must call the getObject methods from the result
                // set in the same order as the columns you selected in your SQL SELECT.
                // And, you cannot read (do a getObject) on the same column more than once.
                // The result set is like sequential text file which you can only
                // read in order and you only get one shot reading each item.
                sb.append("<tr>");

                sb.append(FormatUtils.formatStringTd(rst.getObject(1)));
                sb.append(FormatUtils.formatStringTd(rst.getObject(2)));
                sb.append(FormatUtils.formatIntegerTd(rst.getObject(3)));
                sb.append(FormatUtils.formatStringTd(rst.getObject(4)));
                sb.append(FormatUtils.formatPhoneTd(rst.getObject(5)));
                sb.append("</tr>\n");
            }
            sb.append("</table>");
            rst.close();
            stmt.close();
            return sb.toString();
        } catch (Exception e) {
            return "Exception thrown in InfoSql.listAllInfo(): " + e.getMessage()
                    + "<br/> partial output: <br/>" + sb.toString();
        }
    }
    public static String listDelInfo(String cssClassForResultSetTable, DbConn dbc,
            String delFn, String delIcon ) {

        // Prepare some HTML that will be used repeatedly for the delete icon that
        // calls a delete javascript function (see below).
        if ((delIcon == null) || (delIcon.length() == 0)) {
            return "InfoSql.listAllInfo() error: delete Icon file name (String input parameter) is null or empty.";
        }
        if ((delFn == null) || (delFn.length() == 0)) {
            return "InfoSql.listAllInfo() error: delete javascript function name (String input parameter) is null or empty.";
        }

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
            String sql = "SELECT pricing_info_id, product_name, pricing_info, dis_rate, user_email, phone "
                    + "FROM pricing_info, product, web_user "
                    + "WHERE pricing_info.product_id = product.product_id AND pricing_info.web_user_id = web_user.web_user_id "
                    + "ORDER BY product_name";
            stmt = dbc.getConn().prepareStatement(sql);
            rst = stmt.executeQuery();
            //sb.append("executed the query " + "<br/><br/>");

            sb.append("<table class='" + cssClassForResultSetTable + "'>");
            sb.append("<tr>");
            sb.append("<th>Delete</th>");// extra column at left for delete icon
            sb.append("<th>Product Name</th>");
            sb.append("<th>Pricing Info</th>");
            sb.append("<th>Discount Rate</th>");
            sb.append("<th>User Email</th>");
            sb.append("<th>Phone Number</th>");
            sb.append("</tr>");

            while (rst.next()) {
                // I'm pretty sure that you must call the getObject methods from the result
                // set in the same order as the columns you selected in your SQL SELECT.
                // And, you cannot read (do a getObject) on the same column more than once.
                // The result set is like sequential text file which you can only
                // read in order and you only get one shot reading each item.

                // since we want to use the primary key value several times, 
                // we save this object so we reuse it.
                Object primaryKeyObj = rst.getObject(1);
                Integer primaryKeyInt = (Integer) primaryKeyObj;
                sb.append("<tr>");

                // this is the column with a delete icon that has a link to a javascript function.
                // the input parameter to the delete javascript function is the PK of the user in this row.
                sb.append(delStart + primaryKeyInt.toString() + delEnd);

                sb.append(FormatUtils.formatStringTd(rst.getObject(2)));
                sb.append(FormatUtils.formatStringTd(rst.getObject(3)));
                sb.append(FormatUtils.formatIntegerTd(rst.getObject(4)));
                sb.append(FormatUtils.formatStringTd(rst.getObject(5)));
                sb.append(FormatUtils.formatPhoneTd(rst.getObject(6)));
                sb.append("</tr>\n");
            }
            sb.append("</table>");
            rst.close();
            stmt.close();
            return sb.toString();
        } catch (Exception e) {
            return "Exception thrown in InfoSql.listAllInfo(): " + e.getMessage()
                    + "<br/> partial output: <br/>" + sb.toString();
        }
    }
}
