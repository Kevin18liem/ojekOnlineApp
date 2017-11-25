
package ojeksoap.controller;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the ojeksoap.controller package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

    private final static QName _CreateOrder_QNAME = new QName("http://controller.ojeksoap/", "createOrder");
    private final static QName _GetDriverResponse_QNAME = new QName("http://controller.ojeksoap/", "getDriverResponse");
    private final static QName _SearchDriverResponse_QNAME = new QName("http://controller.ojeksoap/", "searchDriverResponse");
    private final static QName _SearchDriver_QNAME = new QName("http://controller.ojeksoap/", "searchDriver");
    private final static QName _CreateOrderResponse_QNAME = new QName("http://controller.ojeksoap/", "createOrderResponse");
    private final static QName _GetDriver_QNAME = new QName("http://controller.ojeksoap/", "getDriver");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: ojeksoap.controller
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link CreateOrder }
     * 
     */
    public CreateOrder createCreateOrder() {
        return new CreateOrder();
    }

    /**
     * Create an instance of {@link GetDriverResponse }
     * 
     */
    public GetDriverResponse createGetDriverResponse() {
        return new GetDriverResponse();
    }

    /**
     * Create an instance of {@link SearchDriverResponse }
     * 
     */
    public SearchDriverResponse createSearchDriverResponse() {
        return new SearchDriverResponse();
    }

    /**
     * Create an instance of {@link SearchDriver }
     * 
     */
    public SearchDriver createSearchDriver() {
        return new SearchDriver();
    }

    /**
     * Create an instance of {@link CreateOrderResponse }
     * 
     */
    public CreateOrderResponse createCreateOrderResponse() {
        return new CreateOrderResponse();
    }

    /**
     * Create an instance of {@link GetDriver }
     * 
     */
    public GetDriver createGetDriver() {
        return new GetDriver();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link CreateOrder }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://controller.ojeksoap/", name = "createOrder")
    public JAXBElement<CreateOrder> createCreateOrder(CreateOrder value) {
        return new JAXBElement<CreateOrder>(_CreateOrder_QNAME, CreateOrder.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetDriverResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://controller.ojeksoap/", name = "getDriverResponse")
    public JAXBElement<GetDriverResponse> createGetDriverResponse(GetDriverResponse value) {
        return new JAXBElement<GetDriverResponse>(_GetDriverResponse_QNAME, GetDriverResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link SearchDriverResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://controller.ojeksoap/", name = "searchDriverResponse")
    public JAXBElement<SearchDriverResponse> createSearchDriverResponse(SearchDriverResponse value) {
        return new JAXBElement<SearchDriverResponse>(_SearchDriverResponse_QNAME, SearchDriverResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link SearchDriver }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://controller.ojeksoap/", name = "searchDriver")
    public JAXBElement<SearchDriver> createSearchDriver(SearchDriver value) {
        return new JAXBElement<SearchDriver>(_SearchDriver_QNAME, SearchDriver.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link CreateOrderResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://controller.ojeksoap/", name = "createOrderResponse")
    public JAXBElement<CreateOrderResponse> createCreateOrderResponse(CreateOrderResponse value) {
        return new JAXBElement<CreateOrderResponse>(_CreateOrderResponse_QNAME, CreateOrderResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetDriver }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://controller.ojeksoap/", name = "getDriver")
    public JAXBElement<GetDriver> createGetDriver(GetDriver value) {
        return new JAXBElement<GetDriver>(_GetDriver_QNAME, GetDriver.class, null, value);
    }

}
