//package cn.dovahkiin.commons.configs;
//
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//
//import javax.servlet.MultipartConfigElement;
//import java.io.File;
//
//@Configuration
//public class MultipartConfig {
//    /**
//     * 文件上传临时路径
//     */
//    @Bean
//    public MultipartConfigElement multipartConfigElement() {
//        String location = System.getProperty("user.dir") + "/data/tmp";
//        File tmpFile = new File(location);
//        if (!tmpFile.exists()) {
//            tmpFile.mkdirs();
//        }
//        return new MultipartConfigElement("D:/temp");
//    }
//}
