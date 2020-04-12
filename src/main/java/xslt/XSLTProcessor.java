package xslt;

import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.ByteArrayInputStream;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Set;

public class XSLTProcessor {

    private HashMap<String, Integer> parameters;
    private Config config = null;


    public void setParameters(HashMap<String, Integer> parameters) {
        this.parameters = parameters;
    }

    public void setUriResolver(HashMap<String, byte[]> imports) {
        config = new Config(imports);
    }

    public String transform(byte[] xslt, byte[] xml) throws TransformerException {

        TransformerFactory tFactory;

        if (config == null) {
            tFactory = TransformerFactory.newInstance("net.sf.saxon.TransformerFactoryImpl", null);
        } else {
            tFactory = config.getFactory();
        }

        final StringWriter writer = new StringWriter();
        Transformer transformer = tFactory.newTransformer(new StreamSource(new ByteArrayInputStream(xslt)));

        if (parameters != null) {
            Set<String> names = parameters.keySet();
            for (String name : names) {
                transformer.setParameter(name, parameters.get(name));
            }
        }

        StreamResult standardResult = new StreamResult(writer);
        transformer.transform(new StreamSource(new ByteArrayInputStream(xml)), standardResult);
        return writer.toString();


    }

}