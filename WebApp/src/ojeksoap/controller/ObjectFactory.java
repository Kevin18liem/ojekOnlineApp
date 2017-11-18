
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

    private final static QName _GetDriverHistoryByUsernameResponse_QNAME = new QName("http://controller.ojeksoap/", "getDriverHistoryByUsernameResponse");
    private final static QName _HideHistoryByUsernameResponse_QNAME = new QName("http://controller.ojeksoap/", "hideHistoryByUsernameResponse");
    private final static QName _GetPreviousOrderByUsernameResponse_QNAME = new QName("http://controller.ojeksoap/", "getPreviousOrderByUsernameResponse");
    private final static QName _HideHistoryByUsername_QNAME = new QName("http://controller.ojeksoap/", "hideHistoryByUsername");
    private final static QName _HideHistoryDriverById_QNAME = new QName("http://controller.ojeksoap/", "hideHistoryDriverById");
    private final static QName _HideHistoryDriverByIdResponse_QNAME = new QName("http://controller.ojeksoap/", "hideHistoryDriverByIdResponse");
    private final static QName _GetPreviousOrderByUsername_QNAME = new QName("http://controller.ojeksoap/", "getPreviousOrderByUsername");
    private final static QName _GetDriverHistoryByUsername_QNAME = new QName("http://controller.ojeksoap/", "getDriverHistoryByUsername");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: ojeksoap.controller
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link GetDriverHistoryByUsernameResponse }
     * 
     */
    public GetDriverHistoryByUsernameResponse createGetDriverHistoryByUsernameResponse() {
        return new GetDriverHistoryByUsernameResponse();
    }

    /**
     * Create an instance of {@link HideHistoryByUsernameResponse }
     * 
     */
    public HideHistoryByUsernameResponse createHideHistoryByUsernameResponse() {
        return new HideHistoryByUsernameResponse();
    }

    /**
     * Create an instance of {@link GetPreviousOrderByUsernameResponse }
     * 
     */
    public GetPreviousOrderByUsernameResponse createGetPreviousOrderByUsernameResponse() {
        return new GetPreviousOrderByUsernameResponse();
    }

    /**
     * Create an instance of {@link HideHistoryByUsername }
     * 
     */
    public HideHistoryByUsername createHideHistoryByUsername() {
        return new HideHistoryByUsername();
    }

    /**
     * Create an instance of {@link HideHistoryDriverById }
     * 
     */
    public HideHistoryDriverById createHideHistoryDriverById() {
        return new HideHistoryDriverById();
    }

    /**
     * Create an instance of {@link HideHistoryDriverByIdResponse }
     * 
     */
    public HideHistoryDriverByIdResponse createHideHistoryDriverByIdResponse() {
        return new HideHistoryDriverByIdResponse();
    }

    /**
     * Create an instance of {@link GetPreviousOrderByUsername }
     * 
     */
    public GetPreviousOrderByUsername createGetPreviousOrderByUsername() {
        return new GetPreviousOrderByUsername();
    }

    /**
     * Create an instance of {@link GetDriverHistoryByUsername }
     * 
     */
    public GetDriverHistoryByUsername createGetDriverHistoryByUsername() {
        return new GetDriverHistoryByUsername();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetDriverHistoryByUsernameResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://controller.ojeksoap/", name = "getDriverHistoryByUsernameResponse")
    public JAXBElement<GetDriverHistoryByUsernameResponse> createGetDriverHistoryByUsernameResponse(GetDriverHistoryByUsernameResponse value) {
        return new JAXBElement<GetDriverHistoryByUsernameResponse>(_GetDriverHistoryByUsernameResponse_QNAME, GetDriverHistoryByUsernameResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link HideHistoryByUsernameResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://controller.ojeksoap/", name = "hideHistoryByUsernameResponse")
    public JAXBElement<HideHistoryByUsernameResponse> createHideHistoryByUsernameResponse(HideHistoryByUsernameResponse value) {
        return new JAXBElement<HideHistoryByUsernameResponse>(_HideHistoryByUsernameResponse_QNAME, HideHistoryByUsernameResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetPreviousOrderByUsernameResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://controller.ojeksoap/", name = "getPreviousOrderByUsernameResponse")
    public JAXBElement<GetPreviousOrderByUsernameResponse> createGetPreviousOrderByUsernameResponse(GetPreviousOrderByUsernameResponse value) {
        return new JAXBElement<GetPreviousOrderByUsernameResponse>(_GetPreviousOrderByUsernameResponse_QNAME, GetPreviousOrderByUsernameResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link HideHistoryByUsername }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://controller.ojeksoap/", name = "hideHistoryByUsername")
    public JAXBElement<HideHistoryByUsername> createHideHistoryByUsername(HideHistoryByUsername value) {
        return new JAXBElement<HideHistoryByUsername>(_HideHistoryByUsername_QNAME, HideHistoryByUsername.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link HideHistoryDriverById }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://controller.ojeksoap/", name = "hideHistoryDriverById")
    public JAXBElement<HideHistoryDriverById> createHideHistoryDriverById(HideHistoryDriverById value) {
        return new JAXBElement<HideHistoryDriverById>(_HideHistoryDriverById_QNAME, HideHistoryDriverById.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link HideHistoryDriverByIdResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://controller.ojeksoap/", name = "hideHistoryDriverByIdResponse")
    public JAXBElement<HideHistoryDriverByIdResponse> createHideHistoryDriverByIdResponse(HideHistoryDriverByIdResponse value) {
        return new JAXBElement<HideHistoryDriverByIdResponse>(_HideHistoryDriverByIdResponse_QNAME, HideHistoryDriverByIdResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetPreviousOrderByUsername }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://controller.ojeksoap/", name = "getPreviousOrderByUsername")
    public JAXBElement<GetPreviousOrderByUsername> createGetPreviousOrderByUsername(GetPreviousOrderByUsername value) {
        return new JAXBElement<GetPreviousOrderByUsername>(_GetPreviousOrderByUsername_QNAME, GetPreviousOrderByUsername.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetDriverHistoryByUsername }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://controller.ojeksoap/", name = "getDriverHistoryByUsername")
    public JAXBElement<GetDriverHistoryByUsername> createGetDriverHistoryByUsername(GetDriverHistoryByUsername value) {
        return new JAXBElement<GetDriverHistoryByUsername>(_GetDriverHistoryByUsername_QNAME, GetDriverHistoryByUsername.class, null, value);
    }

}
