/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package view;
// classes imported from java.sql.*

import java.sql.PreparedStatement;
import java.sql.ResultSet;

// classes in my project
import dbUtils.DbConn;
import dbUtils.FormatUtils;

public class Search {

    //method that returns the select tag for given input
    public static String selectTag(String sqlSelect, String selectTagName, int firstOptionValueId,
            String firstOptionValueName, int selectedOptionValueId, DbConn dbc) {

        PreparedStatement stmt = null;
        ResultSet results = null;
        try {
            stmt = dbc.getConn().prepareStatement(sqlSelect);
            results = stmt.executeQuery();

            String select = "<select name ='" + selectTagName + "'> <option value='" + firstOptionValueId;
            if (selectedOptionValueId == firstOptionValueId) {
                select = select + "' selected='selected'>";

                select = select + firstOptionValueName + "</option>";
            } else {
                select = select + "'>" + firstOptionValueName + "</option>";
            }
            while (results.next()) {

                int resultId = results.getInt(1);
                String resultName = (String) results.getObject(2);
                if (!resultName.equals(firstOptionValueName)) {
                    select += "<option value ='" + resultId;
                    if (selectedOptionValueId == resultId) {
                        select = select + "'selected ='selected'>";

                        select = select + resultName + "</option>";
                    } else {
                        select = select + "'>" + resultName + "</option>";
                    }
                }

            }
            select += "</select>";
            stmt.close();
            results.close();
            return select;
        } catch (Exception e) {
            return "Error" + e.getMessage();
        }
    }

    public static String searchInfo(String cssTableClass, String searchUser,
            String searchProduct, String disrate, DbConn dbc) {

        int selectUser = Integer.parseInt(searchUser);
        int selectProduct = Integer.parseInt(searchProduct);
        int selectDisrate = 0;
        if (!disrate.isEmpty()) {
            if (disrate.matches("[-+]?\\d+(\\.\\d+)?")) {
                selectDisrate = Integer.parseInt(disrate);
            } else {
                selectDisrate = -1;
            }
        }
        StringBuilder sb = new StringBuilder("");
        PreparedStatement stmt = null;
        ResultSet results = null;
        try {
            //sb.append("ready to create the statement & execute query " + "<br/>");
            String sql = "SELECT product_name, pricing_info, dis_rate, user_email, phone "
                    + "FROM pricing_info, product, web_user "
                    + "WHERE pricing_info.product_id = product.product_id AND pricing_info.web_user_id = web_user.web_user_id ";
            //+ "AND user_email LIKE ? AND product_name LIKE ?"
            //+ "ORDER BY product_name";
            if (selectUser != 0) {
                sql += "AND web_user.web_user_id= ?";
            }
            if (selectProduct != 0) {
                sql += " AND product.product_id= ?";
            }
            if (!disrate.equals("")) {
                sql += " AND dis_rate= ?";
            }

            stmt = dbc.getConn().prepareStatement(sql);

            // If searchEmailStartsWith is empty string, no problem (will match all email addresses)
            // If there is no match, also no problem, but your result set will be empty.
            int questionMark = 1;
            if (selectUser != 0) {
                stmt.setInt(questionMark, selectUser);
                questionMark++;
            }

            if (selectProduct != 0) {
                stmt.setInt(questionMark, selectProduct);
                questionMark++;
            }

            if (!disrate.equals("")) {
                stmt.setInt(questionMark, selectDisrate);
                questionMark++;
            }

            results = stmt.executeQuery();

            //sb.append("executed the query " + "<br/><br/>");
            sb.append("<table class='");
            sb.append(cssTableClass);
            sb.append("'>");
            sb.append("<tr>");
            sb.append("<th style='text-align:left'>Product Name</th>");
            sb.append("<th style='text-align:left'>Pricing Info</th>");
            sb.append("<th style='text-align:left'>Discount Rate</th>");
            sb.append("<th style='text-align:center'>User Email</th>");
            sb.append("<th style='text-align:right'>Phone Number</th></tr>");
            while (results.next()) {
                sb.append("<tr>");
                sb.append(FormatUtils.formatStringTd(results.getObject("product_name")));
                sb.append(FormatUtils.formatStringTd(results.getObject("pricing_info")));
                sb.append(FormatUtils.formatIntegerTd(results.getObject("dis_rate")));
                sb.append(FormatUtils.formatStringTd(results.getObject("user_email")));
                sb.append(FormatUtils.formatPhoneTd(results.getObject("phone")));
                sb.append("</tr>\n");
            }
            sb.append("</table>");
            results.close();
            stmt.close();
            if (selectDisrate == -1) {
                return "Error: Discount rate must be a number" + sb.toString();
            }
            return sb.toString();
        } catch (Exception e) {
            return "Exception thrown in Search.searchInfo(): " + e.getMessage()
                    + "<br/> partial output: <br/>" + sb.toString();
        }
    }
}
