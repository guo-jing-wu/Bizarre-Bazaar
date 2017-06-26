package model.Product;


public class StringData {

    public String productId = "";
    public String productName = "";
    public String productDesc = "";
    public String productPrice = "";
    public String recordStatus = "default"; // will be used later when doing ajax

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
    public String getProductPrice() {
        return productPrice;
    }

    /**
     * @param productPrice the productPrice to set
     */
    public void setProductPrice(String productPrice) {
        this.productPrice = productPrice;
    }

    /**
     * @return the productId
     */
    public String getProductId() {
        return productId;
    }

    /**
     * @param productId the productId to set
     */
    public void setProductId(String productId) {
        this.productId = productId;
    }

    /**
     * @return the recordStatus
     */
    public String getRecordStatus() {
        return recordStatus;
    }

    /**
     * @param recordStatus the recordStatus to set
     */
    public void setRecordStatus(String recordStatus) {
        this.recordStatus = recordStatus;
    }

    @Override
    public String toString() {
        return "productId[" + valueOrNull(productId) + "] productName[" + valueOrNull(productName)
                + "] productDesc[" + valueOrNull(productDesc) + "] productPrice[" + valueOrNull(productPrice)
                + "] recordStatus[" + valueOrNull(recordStatus) + "]";
    } // toString()

    private String valueOrNull(String in) {
        if (in == null) {
            return "null";
        }
        return in;
    }

    public String toJSON() {
        return "({ productId: '" + valueOrNull(productId) + "', productName: '" + valueOrNull(productName)
                + "', productDesc: '" + valueOrNull(productDesc) + "', productPrice: '" + valueOrNull(productPrice)
                + "', recordStatus: '" + valueOrNull(recordStatus) + "' })";
    }
} // class
