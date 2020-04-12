package s3;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.DeleteObjectRequest;
import com.amazonaws.services.s3.model.GetObjectRequest;
import com.amazonaws.services.s3.model.S3Object;

import java.io.InputStream;
import java.util.Scanner;

public class S3Processor {

    private AmazonS3 s3Client;
    private static String SOURCEBUCKETXML;
    private static String SOURCEBUCKETXMLFIRST;
    private static String SOURCEBUCKETXSLT;
    private static String DESTIONATIONBUCKET;
    private byte[] xmlFile;
    private byte[] xslFile;

    public S3Processor() {
        s3Client = AmazonS3ClientBuilder
                .standard()
                .withRegion("eu-central-1")
                .build();
        SOURCEBUCKETXML = "xmlfilesformybt";
        SOURCEBUCKETXMLFIRST = "jsonfilesformybt";
        SOURCEBUCKETXSLT = "xsltmaps";
        DESTIONATIONBUCKET = "finalxmlfiles";
    }

    public boolean upload(String content, String xmlName) {
        s3Client.putObject(DESTIONATIONBUCKET, xmlName, content);
        return false;
    }

    public byte[] getXmlFile(String fileName) {

        S3Object s3Object = s3Client.getObject(new GetObjectRequest(SOURCEBUCKETXML, fileName));
        InputStream objectData = s3Object.getObjectContent();
        Scanner scanner = new Scanner(objectData);
        String file = "";
        while (scanner.hasNext()) {
            file += scanner.nextLine();
        }
        scanner.close();

        if (file != null) {
            return file.getBytes();
        } else {
            return null;
        }
    }

    public byte[] getXslFile(String fileName) {

        S3Object s3Object = s3Client.getObject(new GetObjectRequest(SOURCEBUCKETXSLT, fileName));
        InputStream objectData = s3Object.getObjectContent();
        Scanner scanner = new Scanner(objectData);
        String file = "";
        while (scanner.hasNext()) {
            file += scanner.nextLine();
        }
        scanner.close();

        if (file != null) {
            return file.getBytes();
        } else {
            return null;
        }
    }

    public boolean delete(String fileName) {
        s3Client.deleteObject(new DeleteObjectRequest(SOURCEBUCKETXML, fileName));
        s3Client.deleteObject(new DeleteObjectRequest(SOURCEBUCKETXMLFIRST, fileName));
        return true;
    }
}
