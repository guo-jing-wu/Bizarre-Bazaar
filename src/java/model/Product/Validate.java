package model.Product;

import dbUtils.*;  

/* This class validates a Product object (bundle of pre-validated user entered string values)
 * and saves the validated data into a TypedData object (bundle of typed data values).
 * This class provides one error message per field in a Product object.
 * This class demonstrates the use of "object composition" and
 * "Single Responsibility" software design principles.
 */
public class Validate { 

    // validation error messages, one per field to be validated
    private String productNameMsg = "";
    private String productDescMsg = "";
    private String productPriceMsg = "";
    
    private boolean isValidated = false; // true iff all fields validate ok.
    private String debugMsg = "";
    
    // Product data fields from form (all String, pre-validation), bundled in this object
    private StringData productStringData = new StringData();
    
    // Product data fields after validation (various data types), bundled into this object
    private TypedData productTypedData = new TypedData();
    
    // default constructor is good for first rendering 
    //   -- all error messages are set to "" (empty string).
    public Validate() {
    }

    public Validate(StringData productStringData) {
        // validationUtils method validates each user input (String even if destined for other type) from Product object
        // side effect of validationUtils method puts validated, converted typed value into TypedData object
        this.productStringData = productStringData;

        // this is not needed for insert, but will be needed for update.
        if (productStringData.productId != null && productStringData.productId.length() != 0) {
            ValidateInteger vi = new ValidateInteger(productStringData.productId, true);
            productTypedData.setProductId(vi.getConvertedInteger());
        }

        ValidateString vstr = new ValidateString(productStringData.productName, 45, true);
        productTypedData.setProductName(vstr.getConvertedString());
        this.productNameMsg = vstr.getError();

        vstr = new ValidateString(productStringData.productDesc, 45, false);
        productTypedData.setProductDesc(vstr.getConvertedString());
        this.productDescMsg = vstr.getError();

        ValidateDecimal vdec = new ValidateDecimal(productStringData.productPrice, true);
        productTypedData.setProductPrice(vdec.getConvertedDecimal());
        this.productPriceMsg = vdec.getError();

        String allMessages = this.productNameMsg + this.productDescMsg + this.productPriceMsg;
        isValidated = (allMessages.length() == 0);
    }

    public StringData getStringData() {
        return this.productStringData;
    }

    public TypedData getTypedData() {
        return this.productTypedData;
    }

    public String getProductNameMsg() {
        return this.productNameMsg;
    }

    public String getProductDescMsg() {
        return this.productDescMsg;
    }

    public String getProductPriceMsg() {
        return this.productPriceMsg;
    }

    public boolean isValidated() { 
        return this.isValidated;
    }

    public String getDebugMsg() {
        return this.debugMsg;
    }

    public String getAllValidationErrors() { 
        String allMessages = "productName error: " + this.productNameMsg
                + ", productDesc error: " + this.productDescMsg
                + ", productPrice error: " + this.productPriceMsg;
        return allMessages;
    }
} // class