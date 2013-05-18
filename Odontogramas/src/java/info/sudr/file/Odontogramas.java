package info.sudr.file;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.jstl.sql.Result;
import javax.swing.JOptionPane;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class Odontogramas extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     *     
*/
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter writer = response.getWriter();
        writer.write("call POST with multipart form data");
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     *     
*/
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        if (!ServletFileUpload.isMultipartContent(request)) {
            throw new IllegalArgumentException("Request is not multipart, please 'multipart/form-data' enctype for your form.");
        }
        PrintWriter out = response.getWriter();
        ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
        PrintWriter writer = response.getWriter();

        response.setContentType("text/plain");
        HttpSession sesion = request.getSession();
        Result res = (Result) sesion.getAttribute("consulta");
        String dienteId = (String) sesion.getAttribute("dienteId");
        try {
            List<FileItem> items = uploadHandler.parseRequest(request);
            for (FileItem item : items) {
                if (!item.isFormField()) {

                    FileItem actual = null;
                    actual = item;
                    String fileName = actual.getName();
                    String str = request.getSession().getServletContext().getRealPath("/file/");
                    String str2 = request.getSession().getServletContext().getRealPath("/thumbnails/");


                    fileName = "" + res.getRowsByIndex()[0][0] + "-" + dienteId + "-" + fileName;

                    // nos quedamos solo con el nombre y descartamos el path
                    File fichero = new File(str + "\\" + fileName);





                    // escribimos el fichero colgando del nuevo path
                    actual.write(fichero);

                    BufferedImage img = new BufferedImage(80, 60, BufferedImage.TYPE_INT_RGB);
                    img.createGraphics().drawImage(ImageIO.read(fichero).getScaledInstance(80, 60, Image.SCALE_SMOOTH), 0, 0, null);
                    ImageIO.write(img, "jpg", new File(str2 + "\\" + fileName));





                    writer.write("[{\"name\":\"" + fileName + "\",\"size\":\"" + item.getSize() + "\",\"url\":\"/Odontogramas/file/" + fileName + "\",\"thumbnail_url\":\"/Odontogramas/thumbnails/" + fileName + "\",\"delete_url\":\"/Odontogramas/borrar?file/" + fileName + "&force_delete=true\",\"delete_type\":\"POST\",\"type\":\"" + item.getContentType() + "\"}]");

                    break; // assume we only get one file at a time
                }
            }
        } catch (FileUploadException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            writer.close();
        }
    }
}
