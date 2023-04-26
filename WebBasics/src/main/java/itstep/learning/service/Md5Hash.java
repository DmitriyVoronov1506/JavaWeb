package itstep.learning.service;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
public class Md5Hash implements HashService {
    @Override
    public String getStringHash(String txt) {

        MessageDigest messageDigest;

        try {
            messageDigest = MessageDigest.getInstance("MD5");
        }
        catch(NoSuchAlgorithmException ex) {
            System.err.println("Md5: " + ex.getMessage()) ;
            return null ;
        }

        StringBuilder hash = new StringBuilder();

        for(byte b : messageDigest.digest(txt.getBytes())) {
            hash.append( String.format( "%02x", b ) ) ;
        }

        return hash.toString() ;
    }
}
