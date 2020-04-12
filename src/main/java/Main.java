import activity.ActivityProcessor;
import javax.xml.transform.TransformerException;


import java.io.IOException;



public class Main {

    public static void main(String[] args) throws IOException, TransformerException {
        new ActivityProcessor().listen();

    }
}
