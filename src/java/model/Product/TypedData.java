package model.Product;

/* This class just bundles together all the pre-validated String values that a 
 * user might enter as part of a product record. 
 */
public class TypedData {

    private Integer productId = null;
    private String productName = "";
    private String productDesc = "";
    private java.math.BigDecimal productPrice = null;

    public String displayHTML() {
        return buildDisplay("<br>");
    }

    public String displayLog() {
        return buildDisplay("\n");
    }

    // pass in "\n" for newline, "<br/>" if to be displayed on jsp page.
    public String buildDisplay(String newLineString) {
        return newLineString
                + "Product record" + newLineString
                + "==============" + newLineString
                + "productID: " + myToString(this.getProductId()) + newLineString
                + "productName: " + myToString(this.getProductName()) + newLineString
                + "productDesc: " + myToString(this.getProductDesc()) + newLineString
                + "productPrice: " + myToString(this.getProductPrice()) + newLineString;
    }

    private String myToString(Object obj) {
        if (obj == null) {
            return "null";
        } else {
            return obj.toString();
        }
    }

    /**
     * @return the productId
     */
    public Integer getProductId() {
        return productId;
    }

    /**
     * @param productId the productId to set
     */
    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    /**
     * @return the productName
     */
    public String getProductName() {
        return productName;
    }

    /**
     * @param productName the productName to set
     */
    public void setProductName(String productName) {
        this.productName = productName;
    }

    /**
     * @return the productDesc
     */
    public String getProductDesc() {
        return productDesc;
    }

    /**
     * @param productDesc the productDesc to set
     */
    public void setProductDesc(String productDesc) {
        this.productDesc = productDesc;
    }

    /**
     * @return the productPrice
     */
    public java.math.BigDecimal getProductPrice() {
        return productPrice;
    }

    /**
     * @param productPrice the productPrice to set
     */
    public void setProductPrice(java.math.BigDecimal productPrice) {
        this.productPrice = productPrice;
    }

}
