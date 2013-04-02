/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import conexion.sqlController;
import entity.*;
import entity.controller.*;
import entity.controller.exceptions.IllegalOrphanException;
import entity.controller.exceptions.NonexistentEntityException;
import entity.controller.exceptions.PreexistingEntityException;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.jstl.sql.Result;
import javax.swing.JOptionPane;
import org.eclipse.persistence.sessions.Session;

/**
 *
 * @author Ususario
 */
public class formController extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        try {

            if (request.getParameter("action").equals("municipios")) {
                response.setContentType("application/json;charset=UTF-8");
                String codDe = ((String) request.getParameter("codDep"));
                int codDep = Integer.parseInt(codDe);
                ResultSet listaDeMunicipios = new sqlController().CargarSql("SELECT * FROM `municipios` WHERE `departamentos_codigo1`=" + codDe);




                String aux4 = "{ \"municipios\":[";
                try {
                    while (listaDeMunicipios.next()) {

                        String aux5 = ""
                                + "{"
                                + "\"cod\": \"" + listaDeMunicipios.getInt(1) + "\" ," + " \"nombre\": \"" + listaDeMunicipios.getString(2)
                                + "\""
                                + "},"
                                + "";
                        aux4 += aux5;

                    }
                } catch (SQLException ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                }






                aux4 = aux4.substring(0, aux4.length() - 1);
                aux4 += "]}";




                out.println("[" + aux4 + "]");


            }



            if (request.getParameter("action").equals("validaIdDocente")) {
                String docenteId = ((String) request.getParameter("docenteId"));
                Result exist = new sqlController().CargarSql2("SELECT * FROM `docente` WHERE `iddocente`=" + docenteId);
                if (exist.getRowCount() > 0) {
                    out.println(false);
                } else {
                    out.println(true);
                }


            }
            if (request.getParameter("action").equals("listaPacientes")) {
                HttpSession sesion = request.getSession();
                String idMedico = request.getParameter("id");
                Result med;
                if (idMedico == null || idMedico.equals("") || idMedico.equals("undefined")) {
                    med = (Result) sesion.getAttribute("medico");
                } else {
                    med = new sqlController().CargarSql2("SELECT * FROM `medico` WHERE `idmedico`=" + idMedico);
                    sesion.setAttribute("medico", med);
                }
                sesion.setAttribute("listaDePacientes", new sqlController().CargarSql2("SELECT paciente.* FROM `medico_has_paciente` inner join paciente on paciente.idpersona=`paciente_idpersona` where `medico_idmedico`=" + med.getRowsByIndex()[0][0]));
            }
            if (request.getParameter("action").equals("editarDocente2")) {
                HttpSession sesion = request.getSession();
                Result doc = (Result) sesion.getAttribute("docente");
                String nombre = ((String) request.getParameter("nombre"));
                String clave = ((String) request.getParameter("clave"));
                String estado = ((String) request.getParameter("estado"));
                new sqlController().UpdateSql("UPDATE `odontogramas`.`docente` SET `nombre` = '" + nombre + "',`clave` = '" + clave + "',`codigo` = 'xx2',`estado` = '" + estado + "' WHERE `docente`.`iddocente` =" + doc.getRowsByIndex()[0][0] + "");
            }
            if (request.getParameter("action").equals("editarMedico2")) {
                HttpSession sesion = request.getSession();
                Result med = (Result) sesion.getAttribute("medico");
                String nombre = ((String) request.getParameter("nombre"));
                String clave = ((String) request.getParameter("clave"));
                String direccion = ((String) request.getParameter("direccion"));
                String telefono = ((String) request.getParameter("telefono"));

                new sqlController().UpdateSql("UPDATE `odontogramas`.`medico` SET `nombreUsuario` = '" + nombre + "',`clave` = '" + clave + "',`direccion` = '" + direccion + "',`telefono` = '" + telefono + "' WHERE `medico`.`idmedico` =" + med.getRowsByIndex()[0][0]);
            }
            if (request.getParameter("action").equals("crearDocente")) {
                String docenteId = ((String) request.getParameter("docenteId"));
                String nombre = ((String) request.getParameter("nombre"));
                String clave = ((String) request.getParameter("clave"));
                String estado = ((String) request.getParameter("estado"));
                new sqlController().UpdateSql("INSERT INTO `odontogramas`.`docente` (`iddocente` ,`nombre` ,`clave` ,`codigo` ,`estado`) "
                        + "VALUES ('" + docenteId + "', '" + nombre + "', '" + clave + "', 'xx', '" + estado + "')");
            }
            if (request.getParameter("action").equals("crearCurso")) {
                HttpSession sesion = request.getSession();
                Result docente = (Result) sesion.getAttribute("docente");
                String nombre = ((String) request.getParameter("nombre"));
                String codigo = ((String) request.getParameter("codigo"));
                String estado = ((String) request.getParameter("estado"));
                String anio = ((String) request.getParameter("anio"));
                String periodo = ((String) request.getParameter("periodo"));

                new sqlController().UpdateSql("INSERT INTO `odontogramas`.`curso` (`idcurso` ,`nombre` ,`codigo` ,`estado` ,`anio` ,`periodo`) "
                        + "VALUES (NULL , '" + nombre + "', '" + codigo + "', '" + estado + "', '" + anio + "', '" + periodo + "')");

                Result cursoRecienCreado = new sqlController().CargarSql2("SELECT * FROM curso ORDER BY `idcurso` DESC LIMIT 1");

                new sqlController().UpdateSql("INSERT INTO `odontogramas`.`docente_has_curso` (`docente_iddocente` ,`curso_idcurso`) "
                        + "VALUES ('" + docente.getRowsByIndex()[0][0] + "', '" + cursoRecienCreado.getRowsByIndex()[0][0] + "')");

            }


            if (request.getParameter("action").equals("verDiente")) {
                HttpSession sesion = request.getSession();
                String idDiente = ((String) request.getParameter("diente"));
                sesion.setAttribute("diente", new sqlController().CargarSql2("SELECT * FROM `diente` WHERE `iddiente`=" + idDiente));
                sesion.setAttribute("caraO", new sqlController().CargarSql2("SELECT * FROM `datosconsulta_has_diente` WHERE `diente_iddiente`=" + idDiente + " and `cara` ='Oclusal'"));
                sesion.setAttribute("caraP", new sqlController().CargarSql2("SELECT * FROM `datosconsulta_has_diente` WHERE `diente_iddiente`=" + idDiente + " and `cara` ='Palatina'"));
                sesion.setAttribute("caraL", new sqlController().CargarSql2("SELECT * FROM `datosconsulta_has_diente` WHERE `diente_iddiente`=" + idDiente + " and `cara` ='Lingual'"));
                sesion.setAttribute("caraM", new sqlController().CargarSql2("SELECT * FROM `datosconsulta_has_diente` WHERE `diente_iddiente`=" + idDiente + " and `cara` ='Mesial'"));
                sesion.setAttribute("caraD", new sqlController().CargarSql2("SELECT * FROM `datosconsulta_has_diente` WHERE `diente_iddiente`=" + idDiente + " and `cara` ='Distal'"));
                sesion.setAttribute("caraV", new sqlController().CargarSql2("SELECT * FROM `datosconsulta_has_diente` WHERE `diente_iddiente`=" + idDiente + " and `cara` ='Vestibular'"));
            }

            if (request.getParameter("action").equals("agregarEnfermedad")) {
                HttpSession sesion = request.getSession();
                Result consulta = (Result) sesion.getAttribute("consulta");
                String idDiente = ((String) request.getParameter("diente"));
                String realizar = ((String) request.getParameter("realizar"));
                String[] zonasDelDiente = {"Vestibular", "Mesial", "Distal", "Oclusal", "Palatina"};
                if ((Integer.parseInt(idDiente) > 30 && Integer.parseInt(idDiente) < 50) || (Integer.parseInt(idDiente) > 70 && Integer.parseInt(idDiente) < 86)) {
                    zonasDelDiente[4] = "Lingual";
                }
                String[] zonas = request.getParameterValues("zonaeditar");
                String[] enfermedades = request.getParameterValues("enfermedad");
                if (zonas != null) {

                    if (enfermedades != null) {
                        for (String enfermedad : enfermedades) {

                            if (enfermedad.equals("Caries o recidiva") || enfermedad.equals("Obturado")) {
                                for (String zona : zonas) {
                                    new sqlController().UpdateSql("INSERT INTO `odontogramas`.`datosconsulta_has_diente` (`Iddatosconsulta_has_diente` ,`datosConsulta_iddatosConsulta` ,`diente_iddiente` ,`cara` ,`enfermedad`,`realizar`) "
                                            + "VALUES (NULL , '" + consulta.getRowsByIndex()[0][0] + "', '" + idDiente + "', '" + zona + "', '" + enfermedad + "', '" + realizar + "')");
                                }
                            } else {
                                for (String zona2 : zonasDelDiente) {
                                    new sqlController().UpdateSql("INSERT INTO `odontogramas`.`datosconsulta_has_diente` (`Iddatosconsulta_has_diente` ,`datosConsulta_iddatosConsulta` ,`diente_iddiente` ,`cara` ,`enfermedad`,`realizar`) "
                                            + "VALUES (NULL , '" + consulta.getRowsByIndex()[0][0] + "', '" + idDiente + "', '" + zona2 + "', '" + enfermedad + "', '" + realizar + "')");
                                }
                            }
                        }
                    }
                }


                sesion.setAttribute("diente", new sqlController().CargarSql2("SELECT * FROM `diente` WHERE `iddiente`=" + idDiente));
                sesion.setAttribute("caraO", new sqlController().CargarSql2("SELECT * FROM `datosconsulta_has_diente` WHERE `diente_iddiente`=" + idDiente + " and `cara` ='Oclusal'"));
                sesion.setAttribute("caraP", new sqlController().CargarSql2("SELECT * FROM `datosconsulta_has_diente` WHERE `diente_iddiente`=" + idDiente + " and `cara` ='Palatina'"));
                sesion.setAttribute("caraL", new sqlController().CargarSql2("SELECT * FROM `datosconsulta_has_diente` WHERE `diente_iddiente`=" + idDiente + " and `cara` ='Lingual'"));
                sesion.setAttribute("caraM", new sqlController().CargarSql2("SELECT * FROM `datosconsulta_has_diente` WHERE `diente_iddiente`=" + idDiente + " and `cara` ='Mesial'"));
                sesion.setAttribute("caraD", new sqlController().CargarSql2("SELECT * FROM `datosconsulta_has_diente` WHERE `diente_iddiente`=" + idDiente + " and `cara` ='Distal'"));
                sesion.setAttribute("caraV", new sqlController().CargarSql2("SELECT * FROM `datosconsulta_has_diente` WHERE `diente_iddiente`=" + idDiente + " and `cara` ='Vestibular'"));
            }


            if (request.getParameter("action").equals("eliminarEnfermedad")) {
                HttpSession sesion = request.getSession();
                Result consulta = (Result) sesion.getAttribute("consulta");
                String idDiente = ((String) request.getParameter("diente"));
                String[] zonasDelDiente = {"Vestibular", "Mesial", "Distal", "Oclusal", "Palatina"};
                if (Integer.parseInt(idDiente) > 30 && Integer.parseInt(idDiente) < 50 || Integer.parseInt(idDiente) > 70) {
                    zonasDelDiente[4] = "Lingual";
                }
                String[] zonas = request.getParameterValues("zonaeditar");
                String[] enfermedades = request.getParameterValues("enfermedad");
                if (zonas != null) {

                    if (enfermedades != null) {
                        for (String enfermedad : enfermedades) {

                            if (enfermedad.equals("Caries o recidiva") || enfermedad.equals("Obturado")) {
                                for (String zona : zonas) {
                                    new sqlController().UpdateSql("DELETE FROM `datosconsulta_has_diente` WHERE `diente_iddiente`=" + idDiente + " and `cara`='" + zona + "' and `enfermedad`='" + enfermedad + "' and `datosConsulta_iddatosConsulta`='" + consulta.getRowsByIndex()[0][0] + "'");
                                }
                            } else {
                                for (String zona2 : zonasDelDiente) {
                                    new sqlController().UpdateSql("DELETE FROM `datosconsulta_has_diente` WHERE `diente_iddiente`=" + idDiente + " and `cara`='" + zona2 + "' and `enfermedad`='" + enfermedad + "' and `datosConsulta_iddatosConsulta`='" + consulta.getRowsByIndex()[0][0] + "'");
                                }
                            }
                        }
                    }
                }


                sesion.setAttribute("diente", new sqlController().CargarSql2("SELECT * FROM `diente` WHERE `iddiente`=" + idDiente));
                sesion.setAttribute("caraO", new sqlController().CargarSql2("SELECT * FROM `datosconsulta_has_diente` WHERE `diente_iddiente`=" + idDiente + " and `cara` ='Oclusal'"));
                sesion.setAttribute("caraP", new sqlController().CargarSql2("SELECT * FROM `datosconsulta_has_diente` WHERE `diente_iddiente`=" + idDiente + " and `cara` ='Palatina'"));
                sesion.setAttribute("caraL", new sqlController().CargarSql2("SELECT * FROM `datosconsulta_has_diente` WHERE `diente_iddiente`=" + idDiente + " and `cara` ='Lingual'"));
                sesion.setAttribute("caraM", new sqlController().CargarSql2("SELECT * FROM `datosconsulta_has_diente` WHERE `diente_iddiente`=" + idDiente + " and `cara` ='Mesial'"));
                sesion.setAttribute("caraD", new sqlController().CargarSql2("SELECT * FROM `datosconsulta_has_diente` WHERE `diente_iddiente`=" + idDiente + " and `cara` ='Distal'"));
                sesion.setAttribute("caraV", new sqlController().CargarSql2("SELECT * FROM `datosconsulta_has_diente` WHERE `diente_iddiente`=" + idDiente + " and `cara` ='Vestibular'"));
            }




            if (request.getParameter("action").equals("guardarDatosPer")) {
                HttpSession sesion = request.getSession();
                String Nombre = ((String) request.getParameter("nombre"));
                String Direccion = ((String) request.getParameter("direccion"));
                String Idpersona = ((String) request.getParameter("identificacion"));
                String NumAfiliacion = ((String) request.getParameter("afiliacion"));
                String Telefono = ((String) request.getParameter("telefono"));
                String codigomun = (String) (request.getParameter("municipio"));
                SimpleDateFormat formatoDelTexto = new SimpleDateFormat("yyyy-MM-dd");
                String sFecha = (String) request.getParameter("fecha");
                Date fecha = null;
                try {

                    fecha = formatoDelTexto.parse(sFecha);

                } catch (ParseException ex) {

                    ex.printStackTrace();

                }

                String Sexo = ((String) request.getParameter("sexo"));
                String EstadoCivil = ((String) request.getParameter("estadoCivil"));
                String prof = (String) request.getParameter("profesion");

                new sqlController().UpdateSql("INSERT INTO `odontogramas`.`paciente` (`idpersona` ,`nombre` ,`direccion` ,`num_afiliacion` ,`telefono` ,`sexo` ,`estadoCivil` ,`fechaNacimiento` ,`municipios_codigo` ,`profesiones_codigo`) "
                        + "VALUES ('" + Idpersona + "', '" + Nombre + "', '" + Direccion + "', '" + NumAfiliacion + "', '" + Telefono + "', '" + Sexo + "', '" + EstadoCivil + "', '" + sFecha + "', '" + codigomun + "', '" + prof + "')");

                Result medico = (Result) sesion.getAttribute("medico");

                new sqlController().UpdateSql("INSERT INTO `odontogramas`.`medico_has_paciente` (`medico_idmedico` ,`paciente_idpersona`) VALUES ('" + medico.getRowsByIndex()[0][0] + "', '" + Idpersona + "')");
                session.setAttribute("listaDePacientes", new sqlController().CargarSql2("SELECT paciente.* FROM `medico` "
                        + "inner join medico_has_paciente on medico.idmedico= medico_has_paciente.`medico_idmedico` "
                        + "inner join paciente on medico_has_paciente.`paciente_idpersona`=paciente.idpersona "
                        + "where medico.idmedico=" + medico.getRowsByIndex()[0][0]));


            }

            if (request.getParameter("action").equals("verPaciente")) {
                String idPersona = request.getParameter("id");
                Result pa = new sqlController().CargarSql2("SELECT * FROM `paciente` WHERE `idpersona`=" + idPersona);
                HttpSession sesion = request.getSession();
                sesion.setAttribute("paciente", pa);
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                String fecha = sdf.format(pa.getRowsByIndex()[0][7]);
                sesion.setAttribute("fecha", fecha);
                sesion.setAttribute("departamentos", new sqlController().CargarSql2("SELECT * FROM `departamentos`"));
                Result departamento = new sqlController().CargarSql2("SELECT * from paciente inner join municipios on paciente.municipios_codigo=municipios.codigo where paciente.idpersona=" + pa.getRowsByIndex()[0][0]);
                sesion.setAttribute("departamento", departamento);
                ResultSet rs = new sqlController().CargarSql("SELECT * from paciente inner join municipios on paciente.municipios_codigo=municipios.codigo where paciente.idpersona=" + pa.getRowsByIndex()[0][0]);
                try {
                    while (rs.next()) {
                        sesion.setAttribute("municipios", new sqlController().CargarSql2("select * from municipios where municipios.departamentos_codigo1=" + rs.getInt(13)));
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                }
                session.setAttribute("profesiones", new sqlController().CargarSql2("SELECT * FROM `profesiones`"));


            }

            if (request.getParameter("action").equals("subirRadiografias")) {
                String idPersona = request.getParameter("id");
                Result pa = new sqlController().CargarSql2(idPersona);
                HttpSession sesion = request.getSession();
                sesion.setAttribute("paciente", pa);


            }

            if (request.getParameter("action").equals("listarCursos")) {
                HttpSession sesion = request.getSession();
                Result docente = (Result) sesion.getAttribute("docente");
                sesion.setAttribute("cursos", new sqlController().CargarSql2("SELECT * FROM `docente_has_curso` INNER JOIN curso on `curso_idcurso`=curso.idcurso where `docente_iddocente`=" + docente.getRowsByIndex()[0][0]));

            }
            if (request.getParameter("action").equals("listarDocentes")) {
                HttpSession sesion = request.getSession();
                sesion.setAttribute("docentes", new sqlController().CargarSql2("SELECT * FROM `docente`"));

            }
            if (request.getParameter("action").equals("editarDatosPer")) {
                HttpSession sesion = request.getSession();
                Result pa = (Result) sesion.getAttribute("paciente");
                String nombre = ((String) request.getParameter("nombre"));
                String direccion = ((String) request.getParameter("direccion"));
                String numeroAfiliacion = ((String) request.getParameter("afiliacion"));
                String telefono = ((String) request.getParameter("telefono"));
                String codigomun = (String) (request.getParameter("municipio"));

                SimpleDateFormat formatoDelTexto = new SimpleDateFormat("yyyy-MM-dd");
                String sFecha = (String) request.getParameter("fecha");
                Date fecha = null;
                try {

                    fecha = formatoDelTexto.parse(sFecha);

                } catch (ParseException ex) {

                    ex.printStackTrace();

                }

                String Sexo = ((String) request.getParameter("sexo"));
                String EstadoCivil = ((String) request.getParameter("estadoCivil"));
                String prof = (String) request.getParameter("profesion");

                new sqlController().UpdateSql("UPDATE `odontogramas`.`paciente` SET `nombre` = '" + nombre + "',`direccion` = '" + direccion + "',`num_afiliacion` = '" + numeroAfiliacion + "',`telefono` = '" + telefono + "',`sexo` = '" + Sexo + "',`estadoCivil` = '" + EstadoCivil + "',`fechaNacimiento` = '" + sFecha + "',`municipios_codigo` = '" + codigomun + "',`profesiones_codigo` = '" + prof + "' WHERE `paciente`.`idpersona`= '" + pa.getRowsByIndex()[0][0] + "'");

                Result medico = (Result) session.getAttribute("medico");
                session.setAttribute("listaDePacientes", new sqlController().CargarSql2("SELECT paciente.* FROM `medico` "
                        + "inner join medico_has_paciente on medico.idmedico= medico_has_paciente.`medico_idmedico` "
                        + "inner join paciente on medico_has_paciente.`paciente_idpersona`=paciente.idpersona "
                        + "where medico.idmedico=" + medico.getRowsByIndex()[0][0]));

            }

            if (request.getParameter("action").equals("registrarM")) {
                String idPersona = request.getParameter("cedula");
                String nombre = request.getParameter("nombre");
                String direccion = request.getParameter("direccion");
                String telefono = request.getParameter("telefono");
                String curso = request.getParameter("curso");
                String codigo = request.getParameter("codigo");


                Result cur = new sqlController().CargarSql2("SELECT * FROM `curso` WHERE `idcurso`=" + curso);

                if (cur.getRowsByIndex()[0][2].equals(codigo)) {

                    try {
                        Result docentehascurso = new sqlController().CargarSql2("SELECT * FROM `docente_has_curso` WHERE `curso_idcurso`=" + cur.getRowsByIndex()[0][0]);

                        new sqlController().UpdateSql("INSERT INTO `odontogramas`.`medico` (`idmedico` ,`nombreUsuario` ,`clave` ,`direccion` ,`telefono`) "
                                + "VALUES ('" + idPersona + "', '" + nombre + "', '" + idPersona + "', '" + direccion + "', '" + telefono + "')");
                        new sqlController().UpdateSql("INSERT INTO `odontogramas`.`medico_has_curso` (`medico_idmedico` ,`curso_idcurso`) "
                                + "VALUES ('" + idPersona + "', '" + cur.getRowsByIndex()[0][0] + "')");
                        new sqlController().UpdateSql("INSERT INTO `odontogramas`.`docente_has_medico` (`docente_iddocente` ,`medico_idmedico`) "
                                + "VALUES ('" + docentehascurso.getRowsByIndex()[0][0] + "', '" + idPersona + "')");

                    } catch (Exception ex) {
                        out.print(1);
                        Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    out.print(0);
                } else {
                    out.print(1);
                }



            }


            if (request.getParameter("action").equals("listaMedicos")) {
                HttpSession sesion = request.getSession();
                String idDocente = request.getParameter("id");
                Result doc;
                if (idDocente == null || idDocente.equals("") || idDocente.equals("undefined")) {
                    doc = (Result) sesion.getAttribute("docente");
                } else {
                    doc = new sqlController().CargarSql2("SELECT * FROM `docente` WHERE `iddocente`=" + idDocente);
                    sesion.setAttribute("docente", doc);
                }
                sesion.setAttribute("medicos", new sqlController().CargarSql2("SELECT medico.* FROM `docente_has_medico` inner join medico on medico_idmedico=`idmedico`where `docente_iddocente`=" + doc.getRowsByIndex()[0][0]));

            }
            if (request.getParameter("action").equals("listaConsultas")) {
                HttpSession sesion = request.getSession();
                String idPersona = request.getParameter("id");
                Result pa;
                if (idPersona == null || idPersona.equals("") || idPersona.equals("undefined")) {
                    pa = (Result) sesion.getAttribute("paciente");
                } else {
                    pa = new sqlController().CargarSql2("SELECT * FROM `paciente` WHERE `idpersona`=" + idPersona);
                    sesion.setAttribute("paciente", pa);
                }
                session.setAttribute("tratamientos", new sqlController().CargarSql2("SELECT * FROM `tratamiento`"));
                session.setAttribute("diagnosticos", new sqlController().CargarSql2("SELECT * FROM `diagnostico`"));
                sesion.setAttribute("listaDeConsulta", new sqlController().CargarSql2("SELECT * FROM `consulta` WHERE `paciente_idpersona`=" + pa.getRowsByIndex()[0][0]));
                sesion.setAttribute("datosBasicos", new sqlController().CargarSql2("SELECT * FROM `datosbasicos`"));

            }

            if (request.getParameter("action").equals("guardarDatosBasicos")) {
                HttpSession sesion = request.getSession();
                Result Listdb = new sqlController().CargarSql2("SELECT * FROM `datosbasicos`");
                Result pa = (Result) session.getAttribute("paciente");
                Result me = (Result) session.getAttribute("medico");
                String motivo = (String) request.getParameter("motivo");
                String historia = (String) request.getParameter("historia");
                String observaciones = (String) request.getParameter("observaciones");
                String otros = (String) request.getParameter("otros");
                String ultima = (String) request.getParameter("ultima");
                String motivo2 = (String) request.getParameter("motivo2");
                String iddoc = (String) request.getParameter("docente");
                Result doc = new sqlController().CargarSql2("SELECT * FROM `docente` WHERE `iddocente`=" + iddoc);
                Date todaysDate = new java.util.Date();
                SimpleDateFormat formatoDelTexto2 = new SimpleDateFormat("yyyy-MM-dd");
                String formattedDate = formatoDelTexto2.format(todaysDate);

                Date hoy = null;
                try {

                    hoy = formatoDelTexto2.parse(formattedDate);

                } catch (ParseException ex) {

                    ex.printStackTrace();

                }

                Date ultimaD = null;
                try {

                    ultimaD = formatoDelTexto2.parse(ultima);

                } catch (ParseException ex) {

                    ex.printStackTrace();

                }

                new sqlController().UpdateSql("INSERT INTO `odontogramas`.`consulta` (`iddatosConsulta` ,`motivoConsulta` ,`historiaActualEnfermedad` ,`observaciones` ,`otros` ,`ultimaVisitaOdon` ,`motivo` ,`paciente_idpersona` ,`fechaConsulta` ,`pronostico` ,`medico_idmedico` ,`docente_iddocente`) "
                        + "VALUES (NULL , '" + motivo + "', '" + historia + "', '" + observaciones + "', '" + otros + "', '" + ultima + "', '" + motivo2 + "', '" + pa.getRowsByIndex()[0][0] + "', '" + formattedDate + "', NULL , '" + me.getRowsByIndex()[0][0] + "', '" + doc.getRowsByIndex()[0][0] + "')");

                Result consultaRecienCreada = new sqlController().CargarSql2("SELECT * FROM consulta ORDER BY `iddatosConsulta` DESC LIMIT 1");

                for (int i = 0; i < Listdb.getRowCount(); i++) {
                    String valor = (String) request.getParameter("db" + Listdb.getRowsByIndex()[i][0]);
                    new sqlController().UpdateSql("INSERT INTO `odontogramas`.`datosconsulta_has_datosbasicos` (`datosConsulta_iddatosConsulta` ,`datosBasicos_iddatosBasicos` ,`valor` ,`idConsulta_datosBasicos`)"
                            + "VALUES ('" + consultaRecienCreada.getRowsByIndex()[0][0] + "', '" + Listdb.getRowsByIndex()[i][0] + "', '" + valor + "', NULL)");
                }

                session.setAttribute("consulta", consultaRecienCreada);

            }





            if (request.getParameter("action").equals("agregarPronostico")) {
                HttpSession sesion = request.getSession();
                Result con = (Result) sesion.getAttribute("consulta");
                String pronostico = (String) request.getParameter("pronostico");

                new sqlController().UpdateSql("UPDATE `odontogramas`.`consulta` SET `pronostico` = '" + pronostico + "' WHERE `consulta`.`iddatosConsulta` =" + con.getRowsByIndex()[0][0] + "");
            }

            if (request.getParameter("action").equals("agregarOtros")) {
                HttpSession sesion = request.getSession();
                Result con = (Result) sesion.getAttribute("consulta");
                Result listRe = new sqlController().CargarSql2("SELECT * FROM `remision`");
                Result listInt = new sqlController().CargarSql2("SELECT * FROM `interconsulta`");
                Result listPlan = new sqlController().CargarSql2("SELECT * FROM `plantratamiento`");

                new sqlController().UpdateSql("DELETE FROM `datosconsulta_has_plantratamiento` WHERE `datosconsulta_has_plantratamiento`.`datosConsulta_iddatosConsulta` = " + con.getRowsByIndex()[0][0] + "");
                new sqlController().UpdateSql("DELETE FROM `remision_has_datosconsulta` WHERE `remision_has_datosconsulta`.`datosConsulta_iddatosConsulta` = " + con.getRowsByIndex()[0][0] + "");
                new sqlController().UpdateSql("DELETE FROM `interconsulta_has_datosconsulta` WHERE `interconsulta_has_datosconsulta`.`datosConsulta_iddatosConsulta` = " + con.getRowsByIndex()[0][0] + "");



                for (int i = 0; i < listInt.getRowCount(); i++) {
                    String aux = (String) request.getParameter("interconsulta" + i);

                    if (aux != null && !aux.equals("")) {
                        new sqlController().UpdateSql("INSERT INTO `odontogramas`.`interconsulta_has_datosconsulta` (`interconsulta_idinterconsulta` ,`datosConsulta_iddatosConsulta`) "
                                + "VALUES ('" + aux + "', '" + con.getRowsByIndex()[0][0] + "')");
                    }
                }
                for (int i = 0; i < listRe.getRowCount(); i++) {
                    String aux = (String) request.getParameter("remision" + i);
                    if (aux != null && !aux.equals("")) {
                        new sqlController().UpdateSql("INSERT INTO `odontogramas`.`remision_has_datosconsulta` (`remision_idremision` ,`datosConsulta_iddatosConsulta`) "
                                + "VALUES ('" + aux + "', '" + con.getRowsByIndex()[0][0] + "')");
                    }
                }
                for (int i = 0; i < listPlan.getRowCount(); i++) {
                    String aux = (String) request.getParameter("plantratamiento" + i);
                    if (aux != null && !aux.equals("")) {
                        new sqlController().UpdateSql("INSERT INTO `odontogramas`.`datosconsulta_has_plantratamiento` (`datosConsulta_iddatosConsulta` ,`planTratamiento_idplanTratamiento`) "
                                + "VALUES ('" + con.getRowsByIndex()[0][0] + "', '" + aux + "')");
                    }

                }

            }



            if (request.getParameter("action").equals("agregarEvolucion")) {
                HttpSession sesion = request.getSession();
                Result con = (Result) sesion.getAttribute("consulta");

                String reciboE = (String) request.getParameter("reciboE");
                String tratamientoE = (String) request.getParameter("tratamientoE");
                String codigoTratE = (String) request.getParameter("codigoTratE");
                Result t = new sqlController().CargarSql2("SELECT * FROM `tratamiento` WHERE `idtratamiento`=" + codigoTratE + "");
                SimpleDateFormat formatoDelTexto = new SimpleDateFormat("yyyy-MM-dd");
                String fechaE = (String) request.getParameter("fechaE");
                Date fecha = null;
                try {

                    fecha = formatoDelTexto.parse(fechaE);

                } catch (ParseException ex) {

                    ex.printStackTrace();

                }

                new sqlController().UpdateSql("INSERT INTO `odontogramas`.`evolucion` (`idevolucion` ,`fecha` ,`reciboPago` ,`abono` ,`saldo` ,`tratamiento_idtratamiento`) "
                        + "VALUES (NULL , '" + fechaE + "', '" + reciboE + "', NULL , NULL , '" + codigoTratE + "')");

            }



            if (request.getParameter("action").equals("verConsulta")) {
                String idConsulta = (String) request.getParameter("id");
                Result con = new sqlController().CargarSql2("SELECT * FROM `consulta` WHERE `iddatosConsulta`=" + idConsulta + "");
                HttpSession sesion = request.getSession();
                sesion.setAttribute("consulta", con);
                sesion.setAttribute("datosconsultaHasDatosbasicos", new sqlController().CargarSql2("SELECT * FROM `datosconsulta_has_datosbasicos` inner join datosbasicos on datosbasicos.iddatosBasicos=datosconsulta_has_datosbasicos.`datosBasicos_iddatosBasicos` WHERE `datosConsulta_iddatosConsulta`=" + con.getRowsByIndex()[0][0]));
                sesion.setAttribute("examenfisicoestomatologicoList", new sqlController().CargarSql2("SELECT * FROM `examenfisicoestomatologico` WHERE `datosConsulta_iddatosConsulta`=" + con.getRowsByIndex()[0][0]));
            }
            if (request.getParameter("action").equals("cambiarEstado")) {
                String idDocente = (String) request.getParameter("id");
                Result doc = new sqlController().CargarSql2("SELECT * FROM `docente` WHERE `iddocente`=" + idDocente + "");
                if (doc.getRowsByIndex()[0][4].equals("activo")) {
                    new sqlController().UpdateSql("UPDATE `odontogramas`.`docente` SET `estado` = 'inactivo' WHERE `docente`.`iddocente` =" + doc.getRowsByIndex()[0][0] + "");
                } else {
                    new sqlController().UpdateSql("UPDATE `odontogramas`.`docente` SET `estado` = 'activo' WHERE `docente`.`iddocente` =" + doc.getRowsByIndex()[0][0] + "");
                }

            }
            if (request.getParameter("action").equals("verDocente")) {
                String idDocente = (String) request.getParameter("id");
                Result doc = new sqlController().CargarSql2("SELECT * FROM `docente` WHERE `iddocente`=" + idDocente + "");
                HttpSession sesion = request.getSession();
                sesion.setAttribute("docente", doc);
            }
            if (request.getParameter("action").equals("verMedico")) {
                String idMedico = (String) request.getParameter("id");
                Result med = new sqlController().CargarSql2("SELECT * FROM `medico` WHERE `idmedico`=" + idMedico + "");
                HttpSession sesion = request.getSession();
                sesion.setAttribute("medico", med);
            }
            if (request.getParameter("action").equals("editarMedico")) {
                String idMedico = (String) request.getParameter("id");
                Result med = new sqlController().CargarSql2("SELECT * FROM `medico` WHERE `idmedico`=" + idMedico + "");
                HttpSession sesion = request.getSession();
                sesion.setAttribute("medico", med);
            }
            if (request.getParameter("action").equals("editarDocente")) {
                String idDocente = (String) request.getParameter("id");
                Result doc = new sqlController().CargarSql2("SELECT * FROM `docente` WHERE `iddocente`=" + idDocente + "");
                HttpSession sesion = request.getSession();
                sesion.setAttribute("docente", doc);
            }


            if (request.getParameter("action").equals("actualizaBoca")) {
                HttpSession sesion = request.getSession();
                Result con = (Result) sesion.getAttribute("consulta");
                sesion.setAttribute("dientesEnfermos", new sqlController().CargarSql2("SELECT `diente_iddiente`,`enfermedad` FROM `datosconsulta_has_diente` where `datosConsulta_iddatosConsulta`=" + con.getRowsByIndex()[0][0] + " GROUP BY diente_iddiente, `enfermedad`"));
                sesion.setAttribute("dientesEnfermosFinales", new sqlController().CargarSql2("SELECT `diente_iddiente`,`enfermedad` FROM `datosconsulta_has_diente` where `datosConsulta_iddatosConsulta`=" + con.getRowsByIndex()[0][0] + " and `realizar`='No' GROUP BY diente_iddiente, `enfermedad`"));
            }
            if (request.getParameter("action").equals("editarConsulta")) {
                String idConsulta = (String) request.getParameter("id");
                Result con = new sqlController().CargarSql2("SELECT * FROM `consulta` WHERE `iddatosConsulta`=" + idConsulta + "");
                HttpSession sesion = request.getSession();
                sesion.setAttribute("consulta", con);
                sesion.setAttribute("diagnosticosExistentes", new sqlController().CargarSql2("SELECT codigo, diagnostico FROM `datosconsulta_has_diagnostico` inner join diagnostico on diagnostico.`iddiagnostico`=`diagnostico_iddiagnostico` WHERE `datosConsulta_iddatosConsulta`=" + con.getRowsByIndex()[0][0]));
                sesion.setAttribute("tratamientosExistentes", new sqlController().CargarSql2("SELECT tratamiento.* FROM `datosconsulta_has_tratamiento` inner join tratamiento on tratamiento.`idtratamiento` =`tratamiento_idtratamiento` WHERE `datosConsulta_iddatosConsulta`=" + con.getRowsByIndex()[0][0]));
                sesion.setAttribute("datosconsultaHasDatosbasicos", new sqlController().CargarSql2("SELECT * FROM `datosconsulta_has_datosbasicos` inner join datosbasicos on datosbasicos.iddatosBasicos=datosconsulta_has_datosbasicos.`datosBasicos_iddatosBasicos` WHERE `datosConsulta_iddatosConsulta`=" + con.getRowsByIndex()[0][0]));
                sesion.setAttribute("examenfisicoestomatologicoList", new sqlController().CargarSql2("SELECT * FROM `examenfisicoestomatologico` WHERE `datosConsulta_iddatosConsulta`=" + con.getRowsByIndex()[0][0]));
                sesion.setAttribute("dientesEnfermos", new sqlController().CargarSql2("SELECT `diente_iddiente`,`enfermedad` FROM `datosconsulta_has_diente` where `datosConsulta_iddatosConsulta`=" + con.getRowsByIndex()[0][0] + " GROUP BY diente_iddiente, `enfermedad`"));
                sesion.setAttribute("dientesEnfermosFinales", new sqlController().CargarSql2("SELECT `diente_iddiente`,`enfermedad` FROM `datosconsulta_has_diente` where `datosConsulta_iddatosConsulta`=" + con.getRowsByIndex()[0][0] + " and `realizar`='No' GROUP BY diente_iddiente, `enfermedad`"));
                sesion.setAttribute("interconsultaE", new sqlController().CargarSql2("SELECT `interconsulta_idinterconsulta` FROM `interconsulta_has_datosconsulta` WHERE `datosConsulta_iddatosConsulta`=" + con.getRowsByIndex()[0][0]));
                sesion.setAttribute("planTratamientoE", new sqlController().CargarSql2("SELECT `planTratamiento_idplanTratamiento` FROM `datosconsulta_has_plantratamiento` WHERE `datosConsulta_iddatosConsulta`=" + con.getRowsByIndex()[0][0]));
                sesion.setAttribute("remisionE", new sqlController().CargarSql2("SELECT `remision_idremision` FROM `remision_has_datosconsulta` WHERE `datosConsulta_iddatosConsulta`=" + con.getRowsByIndex()[0][0]));
                sesion.setAttribute("historiaClinica", new sqlController().CargarSql2("SELECT * FROM `historiaclinica` WHERE `consulta_iddatosConsulta`=" + con.getRowsByIndex()[0][0]));
            }

            if (request.getParameter("action").equals("agregarDiagnostico")) {
                HttpSession sesion = request.getSession();
                Result con = (Result) sesion.getAttribute("consulta");
                new sqlController().UpdateSql("DELETE FROM `datosconsulta_has_diagnostico` WHERE `datosconsulta_has_diagnostico`.`datosConsulta_iddatosConsulta` = " + con.getRowsByIndex()[0][0] + "");
                String diagnosticosJuntos = (String) request.getParameter("diagnosticos");
                if (!diagnosticosJuntos.equals("")) {
                    String diagnosticos[] = diagnosticosJuntos.split(",");
                    for (int i = 0; i < diagnosticos.length; i++) {
                        String dia_cod[] = diagnosticos[i].split(" - ");
                        String codigo = dia_cod[1];
                        Diagnostico dia = new DiagnosticoJpaController().findDiagnostico(Integer.parseInt(codigo));
                        new sqlController().UpdateSql("INSERT INTO `odontogramas`.`datosconsulta_has_diagnostico` (`datosConsulta_iddatosConsulta` ,`diagnostico_iddiagnostico`)"
                                + "VALUES ('" + con.getRowsByIndex()[0][0] + "', '" + codigo + "')");

                    }
                }
            }


            if (request.getParameter("action").equals("agregarTratamiento")) {
                HttpSession sesion = request.getSession();
                Result con = (Result) sesion.getAttribute("consulta");
                new sqlController().UpdateSql("DELETE FROM `datosconsulta_has_tratamiento` WHERE `datosconsulta_has_tratamiento`.`datosConsulta_iddatosConsulta` = " + con.getRowsByIndex()[0][0]);

                String tratamientosJuntos = (String) request.getParameter("tratamientos");
                if (!tratamientosJuntos.equals("")) {
                    String tratamientos[] = tratamientosJuntos.split(",");

                    for (int i = 0; i < tratamientos.length; i++) {
                        String tra_cod[] = tratamientos[i].split(" - ");
                        String codigo = tra_cod[1];
                        new sqlController().UpdateSql("INSERT INTO `odontogramas`.`datosconsulta_has_tratamiento` (`datosConsulta_iddatosConsulta` ,`tratamiento_idtratamiento`) "
                                + "VALUES ('" + con.getRowsByIndex()[0][0] + "', '" + codigo + "')");
                    }
                }
            }



            if (request.getParameter("action").equals("guardarDatosBasicos2")) {
                HttpSession sesion = request.getSession();
                Result con = (Result) sesion.getAttribute("consulta");
                String temperatura = (String) request.getParameter("temperatura");
                String pulso = (String) request.getParameter("pulso");
                String tension = (String) request.getParameter("tension");
                String higiene = (String) request.getParameter("higiene");
                String usoSeda = (String) request.getParameter("usoSeda");
                String cepillo = (String) request.getParameter("cepillo");
                String veces = (String) request.getParameter("veces");
                String enjuages1 = (String) request.getParameter("enjuages1");
                String enjuages2 = (String) request.getParameter("enjuages2");
                String habitosYvicios = (String) request.getParameter("habitosYvicios");



                new sqlController().UpdateSql("DELETE FROM `odontogramas`.`examenfisicoestomatologico` WHERE `examenfisicoestomatologico`.`datosConsulta_iddatosConsulta` = " + con.getRowsByIndex()[0][0]);

                new sqlController().UpdateSql("INSERT INTO `odontogramas`.`examenfisicoestomatologico` (`idexamenFisicoEstomatologico` ,`temperatura` ,`pulso` ,`tensionArterial` ,`higieneOral` ,`sedaDental` ,`cepilloDentalUso` ,`vecesAlDia` ,`enjuagesBsinFluor` ,`enjuagesBconFluor` ,`habitosYvicios` ,`datosConsulta_iddatosConsulta`) "
                        + "VALUES (NULL , '" + temperatura + "', '" + pulso + "', '" + tension + "', '" + higiene + "', '" + usoSeda + "', '" + cepillo + "', '" + veces + "', '" + enjuages1 + "', '" + enjuages2 + "', '" + habitosYvicios + "', '" + con.getRowsByIndex()[0][0] + "')");


            }



            if (request.getParameter("action").equals("agregarAntecedentes")) {
                HttpSession sesion = request.getSession();
                Result con = (Result) sesion.getAttribute("consulta");
                String eactual = (String) request.getParameter("eactual");
                String[] dolor = request.getParameterValues("dolor");
                String dolores = "";
                for (String d : dolor) {
                    dolores += d + " ";
                }
                Result historia = new sqlController().CargarSql2("SELECT * FROM `historiaclinica` WHERE `consulta_iddatosConsulta`=" + con.getRowsByIndex()[0][0]);

                if (historia.getRowCount() == 0) {
                    new sqlController().UpdateSql("INSERT INTO `odontogramas`.`historiaclinica` (`idhistoriaClinica` ,`estadoActual` ,`dolor` ,`diente` ,`tejidosVecinos` ,`termicaFrio` ,`evaluaciones` ,`observaciones` ,`etiologia` ,`consulta_iddatosConsulta`) "
                            + "VALUES (NULL , '" + eactual + "', '" + dolores + "', NULL , NULL , NULL , NULL , NULL , NULL , '" + con.getRowsByIndex()[0][0] + "')");


                } else {
                    new sqlController().UpdateSql("UPDATE `odontogramas`.`historiaclinica` SET `estadoActual` = '" + eactual + "', `dolor` = '" + dolores + "' WHERE `historiaclinica`.`idhistoriaClinica` =" + historia.getRowsByIndex()[0][0]);


                }

            }
            if (request.getParameter("action").equals("agregarImpresion")) {
                HttpSession sesion = request.getSession();
                Result con = (Result) sesion.getAttribute("consulta");
                String dienteI = (String) request.getParameter("dienteI");
                String tejidos = (String) request.getParameter("tejidos");
                Result historia = new sqlController().CargarSql2("SELECT * FROM `historiaclinica` WHERE `consulta_iddatosConsulta`=" + con.getRowsByIndex()[0][0]);
                if (historia.getRowCount() == 0) {
                    new sqlController().UpdateSql("INSERT INTO `odontogramas`.`historiaclinica` (`idhistoriaClinica` ,`estadoActual` ,`dolor` ,`diente` ,`tejidosVecinos` ,`termicaFrio` ,`evaluaciones` ,`observaciones` ,`etiologia` ,`consulta_iddatosConsulta`) "
                            + "VALUES (NULL , 'NULL', 'NULL', " + dienteI + " , " + tejidos + " , NULL , NULL , NULL , NULL , '" + con.getRowsByIndex()[0][0] + "')");
                } else {
                    new sqlController().UpdateSql("UPDATE `odontogramas`.`historiaclinica` SET `diente` = '" + dienteI + "', `tejidosVecinos` = '" + tejidos + "' WHERE `historiaclinica`.`idhistoriaClinica` =" + historia.getRowsByIndex()[0][0]);
                }
            }
            if (request.getParameter("action").equals("agregarRadiografico")) {
                HttpSession sesion = request.getSession();
                Result con = (Result) sesion.getAttribute("consulta");
                String evaluacion = (String) request.getParameter("evaluacion");
                String ObservacionesE = (String) request.getParameter("ObservacionesE");
                String etiologia = (String) request.getParameter("etiologia");
                Result historia = new sqlController().CargarSql2("SELECT * FROM `historiaclinica` WHERE `consulta_iddatosConsulta`=" + con.getRowsByIndex()[0][0]);
                if (historia.getRowCount() == 0) {
                    new sqlController().UpdateSql("INSERT INTO `odontogramas`.`historiaclinica` (`idhistoriaClinica` ,`estadoActual` ,`dolor` ,`diente` ,`tejidosVecinos` ,`termicaFrio` ,`evaluaciones` ,`observaciones` ,`etiologia` ,`consulta_iddatosConsulta`) "
                            + "VALUES (NULL , 'NULL', 'NULL', 'NULL' , 'NULL' , 'NULL' , "+evaluacion+" , "+ObservacionesE+" , "+etiologia+" , '" + con.getRowsByIndex()[0][0] + "')");
                } else {
                    new sqlController().UpdateSql("UPDATE `odontogramas`.`historiaclinica` SET `evaluaciones` = '" + evaluacion + "', `observaciones`= '" + ObservacionesE + "', `etiologia`= '" + ObservacionesE + "'  WHERE `historiaclinica`.`idhistoriaClinica` =" + historia.getRowsByIndex()[0][0]);
                }
            }
            if (request.getParameter("action").equals("agregarVitalometrica")) {
                HttpSession sesion = request.getSession();
                Result con = (Result) sesion.getAttribute("consulta");
                String frio = (String) request.getParameter("frio");
                Result historia = new sqlController().CargarSql2("SELECT * FROM `historiaclinica` WHERE `consulta_iddatosConsulta`=" + con.getRowsByIndex()[0][0]);
                if (historia.getRowCount() == 0) {
                    new sqlController().UpdateSql("INSERT INTO `odontogramas`.`historiaclinica` (`idhistoriaClinica` ,`estadoActual` ,`dolor` ,`diente` ,`tejidosVecinos` ,`termicaFrio` ,`evaluaciones` ,`observaciones` ,`etiologia` ,`consulta_iddatosConsulta`) "
                            + "VALUES (NULL , 'NULL', 'NULL', 'NULL' , 'NULL' , "+frio+" , NULL , NULL , NULL , '" + con.getRowsByIndex()[0][0] + "')");
                } else {
                    new sqlController().UpdateSql("UPDATE `odontogramas`.`historiaclinica` SET `termicaFrio` = '" + frio + "' WHERE `historiaclinica`.`idhistoriaClinica` =" + historia.getRowsByIndex()[0][0]);
                }
            }


            if (request.getParameter("action").equals("guardarPron")) {
                HttpSession sesion = request.getSession();
                Result con = (Result) sesion.getAttribute("consulta");
                Result listR = (Result) sesion.getAttribute("remision");

                new sqlController().UpdateSql("DELETE FROM `remision_has_datosconsulta` WHERE `remision_has_datosconsulta`.`datosConsulta_iddatosConsulta` = " + con.getRowsByIndex()[0][0] + "");
                new sqlController().UpdateSql("DELETE FROM `interconsulta_has_datosconsulta` WHERE `interconsulta_has_datosconsulta`.`datosConsulta_iddatosConsulta` = " + con.getRowsByIndex()[0][0] + "");
                new sqlController().UpdateSql("DELETE FROM `datosconsulta_has_plantratamiento` WHERE `datosconsulta_has_plantratamiento`.`datosConsulta_iddatosConsulta` = " + con.getRowsByIndex()[0][0] + "");

                for (int i = 0; i < listR.getRowCount(); i++) {
                    if (request.getParameter("remision" + i) != null) {
                        new sqlController().UpdateSql("INSERT INTO `odontogramas`.`remision_has_datosconsulta` (`remision_idremision` ,`datosConsulta_iddatosConsulta`) "
                                + "VALUES ('" + listR.getRowsByIndex()[i][0] + "', '" + con.getRowsByIndex()[0][0] + "')");

                    }


                }

                Result listI = (Result) sesion.getAttribute("interconsulta");
                for (int i = 0; i < listI.getRowCount(); i++) {
                    if (request.getParameter("interconsulta" + i) != null) {
                        new sqlController().UpdateSql("INSERT INTO `odontogramas`.`interconsulta_has_datosconsulta` (`interconsulta_idinterconsulta` ,`datosConsulta_iddatosConsulta`) "
                                + "VALUES ('" + listI.getRowsByIndex()[i][0] + "', '" + con.getRowsByIndex()[0][0] + "')");
                    }
                }
                Result listP = (Result) sesion.getAttribute("planTratamiento");


                for (int i = 0; i < listP.getRowCount(); i++) {
                    if (request.getParameter("plantratamiento" + i) != null) {
                        new sqlController().UpdateSql("INSERT INTO `odontogramas`.`datosconsulta_has_plantratamiento` (`datosConsulta_iddatosConsulta` ,`planTratamiento_idplanTratamiento`) "
                                + "VALUES ('" + con.getRowsByIndex()[0][0] + "', '" + listP.getRowsByIndex()[i][0] + "')");
                    }


                }


                String pronostico = (String) request.getParameter("pronostico");
                new sqlController().UpdateSql("UPDATE `odontogramas`.`consulta` SET `pronostico` = '" + pronostico + "' WHERE `consulta`.`iddatosConsulta` =" + con.getRowsByIndex()[0][0] + "");
            }




        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
