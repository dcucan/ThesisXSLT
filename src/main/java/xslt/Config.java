package xslt;

import javax.xml.transform.Source;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.URIResolver;
import javax.xml.transform.stream.StreamSource;
import java.io.ByteArrayInputStream;
import java.util.HashMap;
import java.util.Set;

public class Config {


    private TransformerFactory tFactory;
    private HashMap<String, byte[]> imports;

    protected Config(HashMap<String, byte[]> imports) {
        tFactory = TransformerFactory.newInstance("net.sf.saxon.TransformerFactoryImpl", null);
        this.imports = imports;
        tFactory.setURIResolver(resolver);
    }

    private URIResolver resolver = new URIResolver() {
        @Override
        public Source resolve(String href, String base) throws TransformerException {
            Set<String> keySet = imports.keySet();
            for (String key : keySet) {
                if (href.contains(key)) {
                    byte[] stylesheet = imports.get(key);
                    return new StreamSource(new ByteArrayInputStream(stylesheet));
                }
            }
            return null;
        }
    };


    protected TransformerFactory getFactory() {
        return tFactory;
    }

}
