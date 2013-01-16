/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.*;
import entity.controller.*;
import entity.controller.exceptions.IllegalOrphanException;
import entity.controller.exceptions.NonexistentEntityException;
import entity.controller.exceptions.PreexistingEntityException;
import java.io.IOException;
import java.io.PrintWriter;
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
                Departamentos dep = new DepartamentosJpaController().findDepartamentos(codDep);
                MunicipiosJpaController conMun = new MunicipiosJpaController();
                List<Municipios> listaDeMunicipios = conMun.findMunicipiosEntities();
                ArrayList<Municipios> mun = new ArrayList<Municipios>();
                for (Municipios m : listaDeMunicipios) {
                    if (m.getDepartamentosCodigo1().getCodigo() == dep.getCodigo()) {
                        mun.add(m);
                    }
                }

                String aux4 = "{ \"municipios\":[";


                for (Municipios m : mun) {
                    String aux5 = ""
                            + "{"
                            + "\"cod\": \"" + m.getCodigo() + "\" ," + " \"nombre\": \"" + m.getNombre()
                            + "\""
                            + "},"
                            + "";
                    aux4 += aux5;

                }

                aux4 = aux4.substring(0, aux4.length() - 1);
                aux4 += "]}";




                out.println("[" + aux4 + "]");


            }



            if (request.getParameter("action").equals("guardarDatosPer")) {
                PacienteJpaController conPa = new PacienteJpaController();
                Paciente pa = new Paciente();
                pa.setNombre((String) request.getParameter("nombre"));
                pa.setDireccion((String) request.getParameter("direccion"));
                pa.setIdpersona((String) request.getParameter("identificacion"));
                pa.setNumAfiliacion((String) request.getParameter("afiliacion"));
                pa.setTelefono((String) request.getParameter("telefono"));
                String codigomun = (String) (request.getParameter("municipio"));
                int codMun = Integer.parseInt(codigomun);
                MunicipiosJpaController ConMun = new MunicipiosJpaController();
                Municipios mun = ConMun.findMunicipios(codMun);
                pa.setMunicipiosCodigo(mun);
                SimpleDateFormat formatoDelTexto = new SimpleDateFormat("yyyy-MM-dd");
                String sFecha = (String) request.getParameter("fecha");
                Date fecha = null;
                try {

                    fecha = formatoDelTexto.parse(sFecha);

                } catch (ParseException ex) {

                    ex.printStackTrace();

                }
                pa.setFechaNacimiento(fecha);
                pa.setSexo((String) request.getParameter("sexo"));
                pa.setEstadoCivil((String) request.getParameter("estadoCivil"));
                String prof = (String) request.getParameter("profesion");
                int codPro = Integer.parseInt(prof);
                Profesiones profes = new ProfesionesJpaController().findProfesiones(codPro);
                pa.setProfesionesCodigo(profes);
                Medico m = (Medico) session.getAttribute("medico");
                ArrayList<Medico> listMedico = new ArrayList<Medico>();
                listMedico.add(m);
                pa.setMedicoList(listMedico);

                try {
                    conPa.create(pa);
                    session.setAttribute("listaDePacientes", new MedicoJpaController().findMedico(m.getIdmedico()).getPacienteList());
                } catch (PreexistingEntityException ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                } catch (Exception ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                }

            }

            if (request.getParameter("action").equals("verPaciente")) {
                String idPersona = request.getParameter("id");
                DiagnosticoJpaController conDi = new DiagnosticoJpaController();
                TratamientoJpaController conTra = new TratamientoJpaController();
                PacienteJpaController conPa = new PacienteJpaController();
                Paciente pa = conPa.findPaciente(idPersona);
                HttpSession sesion = request.getSession();
                sesion.setAttribute("paciente", pa);
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                String fecha = sdf.format(pa.getFechaNacimiento());
                sesion.setAttribute("fecha", fecha);
                sesion.setAttribute("departamentos", new DepartamentosJpaController().findDepartamentosEntities());
                sesion.setAttribute("municipios", new DepartamentosJpaController().findDepartamentos(pa.getMunicipiosCodigo().getDepartamentosCodigo1().getCodigo()).getMunicipiosList());
                session.setAttribute("diagnosticos", conDi.findDiagnosticoEntities());
                session.setAttribute("profesiones", new ProfesionesJpaController().findProfesionesEntities());
                session.setAttribute("tratamientos", conTra.findTratamientoEntities());

            }

            if (request.getParameter("action").equals("subirRadiografias")) {
                String idPersona = request.getParameter("id");
                PacienteJpaController conPa = new PacienteJpaController();
                Paciente pa = conPa.findPaciente(idPersona);
                HttpSession sesion = request.getSession();
                sesion.setAttribute("paciente", pa);


            }

            if (request.getParameter("action").equals("editarDatosPer")) {
                HttpSession sesion = request.getSession();
                Paciente pa = (Paciente) sesion.getAttribute("paciente");

                PacienteJpaController conPa = new PacienteJpaController();
                pa.setNombre((String) request.getParameter("nombre"));
                pa.setDireccion((String) request.getParameter("direccion"));
                pa.setNumAfiliacion((String) request.getParameter("afiliacion"));
                pa.setTelefono((String) request.getParameter("telefono"));
                String codigomun = (String) (request.getParameter("municipio"));
                int codMun = Integer.parseInt(codigomun);
                MunicipiosJpaController ConMun = new MunicipiosJpaController();
                Municipios mun = ConMun.findMunicipios(codMun);
                pa.setMunicipiosCodigo(mun);
                SimpleDateFormat formatoDelTexto = new SimpleDateFormat("yyyy-MM-dd");
                String sFecha = (String) request.getParameter("fecha");
                Date fecha = null;
                try {

                    fecha = formatoDelTexto.parse(sFecha);

                } catch (ParseException ex) {

                    ex.printStackTrace();

                }
                pa.setFechaNacimiento(fecha);
                pa.setSexo((String) request.getParameter("sexo"));
                pa.setEstadoCivil((String) request.getParameter("estadoCivil"));
                String prof = (String) request.getParameter("profesion");
                int codPro = Integer.parseInt(prof);
                Profesiones profes = new ProfesionesJpaController().findProfesiones(codPro);
                pa.setProfesionesCodigo(profes);
                Medico m = (Medico) session.getAttribute("medico");
                ArrayList<Medico> listMedico = new ArrayList<Medico>();
                listMedico.add(m);
                pa.setMedicoList(listMedico);

                try {
                    conPa.edit(pa);
                    session.setAttribute("listaDePacientes", new MedicoJpaController().findMedico(m.getIdmedico()).getPacienteList());
                } catch (PreexistingEntityException ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                } catch (Exception ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (request.getParameter("action").equals("registrarM")) {
                String idPersona = request.getParameter("cedula");
                String nombre = request.getParameter("nombre");
                String direccion = request.getParameter("direccion");
                String telefono = request.getParameter("telefono");
                String curso = request.getParameter("curso");
                String codigo = request.getParameter("codigo");


                MedicoJpaController conMe = new MedicoJpaController();
                CursoJpaController conCu = new CursoJpaController();
                Medico me = new Medico();
                me.setIdmedico(Integer.parseInt(idPersona));
                me.setNombreUsuario(nombre);
                me.setDireccion(direccion);
                me.setTelefono(telefono);
                me.setClave(idPersona);
                List<Curso> listCur = new ArrayList<Curso>();
                Curso cur = conCu.findCurso(Integer.parseInt(curso));
                if (cur.getCodigo().equals(codigo)) {
                    listCur.add(cur);
                    me.setCursoList(listCur);
                    try {
                        conMe.create(me);
                    } catch (PreexistingEntityException ex) {
                        out.print(1);
                        Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                    } catch (Exception ex) {
                        Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    out.print(0);
                } else {
                    out.print(1);
                }



            }


            if (request.getParameter("action").equals("listaConsultas")) {
                String idPersona = request.getParameter("id");

                HttpSession sesion = request.getSession();
                Paciente pa = new PacienteJpaController().findPaciente(idPersona);
                sesion.setAttribute("paciente", pa);

                sesion.setAttribute("listaDeConsulta", pa.getConsultaList());

            }
            if (request.getParameter("action").equals("nuevaConsulta")) {
                HttpSession sesion = request.getSession();
                DatosbasicosJpaController daCon = new DatosbasicosJpaController();
                Paciente pa = (Paciente) session.getAttribute("paciente");
                sesion.setAttribute("datosBasicos", daCon.findDatosbasicosEntities());

            }



            if (request.getParameter("action").equals("guardarDatosBasicos")) {
                HttpSession sesion = request.getSession();
                List<Datosbasicos> Listdb = (List<Datosbasicos>) sesion.getAttribute("datosBasicos");
                Paciente pa = (Paciente) session.getAttribute("paciente");
                Medico me = (Medico) session.getAttribute("medico");

                List<DatosconsultaHasDatosbasicos> dcdb = new ArrayList<DatosconsultaHasDatosbasicos>();
                String motivo = (String) request.getParameter("motivo");
                String historia = (String) request.getParameter("historia");
                String observaciones = (String) request.getParameter("observaciones");
                String otros = (String) request.getParameter("otros");
                String ultima = (String) request.getParameter("ultima");
                String motivo2 = (String) request.getParameter("motivo2");
                String iddoc = (String) request.getParameter("docente");
                Docente doc = new DocenteJpaController().findDocente(Integer.parseInt(iddoc));

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




                Consulta con = new Consulta();
                ConsultaJpaController conCon = new ConsultaJpaController();
                con.setMotivoConsulta(motivo);
                con.setPacienteIdpersona(pa);
                con.setObservaciones(observaciones);
                con.setHistoriaActualEnfermedad(historia);
                con.setMotivo(motivo2);
                con.setOtros(otros);
                con.setFechaConsulta(hoy);
                con.setUltimaVisitaOdon(ultimaD);
                con.setMedicoIdmedico(me);
                con.setDocenteIddocente(doc);
                conCon.create(con);


                List<Consulta> consultas = conCon.findConsultaEntities();
                int mayor = -1;
                for (int j = 0; j < consultas.size(); j++) {
                    if (consultas.get(j).getIddatosConsulta() > mayor) {
                        mayor = consultas.get(j).getIddatosConsulta();

                    }
                }

                Consulta conRecienCreada = conCon.findConsulta(mayor);

                for (int i = 0; i < Listdb.size(); i++) {
                    String valor = (String) request.getParameter("db" + Listdb.get(i).getIddatosBasicos());
                    DatosconsultaHasDatosbasicos aux = new DatosconsultaHasDatosbasicos();
                    aux.setDatosBasicosiddatosBasicos(Listdb.get(i));
                    aux.setDatosConsultaiddatosConsulta(conRecienCreada);
                    aux.setValor(valor);
                    new DatosconsultaHasDatosbasicosJpaController().create(aux);
                    dcdb.add(aux);

                }

                conRecienCreada.setDatosconsultaHasDatosbasicosList(dcdb);
                try {
                    conCon.edit(conRecienCreada);

                } catch (IllegalOrphanException ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                } catch (NonexistentEntityException ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                } catch (Exception ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                }
                session.setAttribute("consulta", conRecienCreada);



            }

            if (request.getParameter("action").equals("agregarDiagnostico")) {
                HttpSession sesion = request.getSession();
                Consulta con = (Consulta) sesion.getAttribute("consulta");
                ConsultaJpaController conC = new ConsultaJpaController();
                List<Diagnostico> listD = new ArrayList<Diagnostico>();
                String diagnosticosJuntos = (String) request.getParameter("diagnosticos");
                if (!diagnosticosJuntos.equals("")) {
                    String diagnosticos[] = diagnosticosJuntos.split(",");
                    for (int i = 0; i < diagnosticos.length; i++) {
                        String dia_cod[] = diagnosticos[i].split(" - ");
                        String codigo = dia_cod[1];
                        Diagnostico dia = new DiagnosticoJpaController().findDiagnostico(Integer.parseInt(codigo));
                        listD.add(dia);
                    }
                }






                con.setDiagnosticoList(listD);
                try {
                    conC.edit(con);
                } catch (IllegalOrphanException ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                } catch (NonexistentEntityException ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                } catch (Exception ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                }




            }


            if (request.getParameter("action").equals("agregarPronostico")) {
                HttpSession sesion = request.getSession();
                Consulta con = (Consulta) sesion.getAttribute("consulta");
                String pronostico = (String) request.getParameter("pronostico");
                ConsultaJpaController coC = new ConsultaJpaController();
                con.setPronostico(pronostico);
                try {
                    coC.edit(con);
                } catch (IllegalOrphanException ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                } catch (NonexistentEntityException ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                } catch (Exception ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (request.getParameter("action").equals("agregarOtros")) {
                HttpSession sesion = request.getSession();
                Consulta con = (Consulta) sesion.getAttribute("consulta");
                List<Remision> listRe = new RemisionJpaController().findRemisionEntities();
                List<Interconsulta> listInt = new InterconsultaJpaController().findInterconsultaEntities();
                List<Plantratamiento> listPlan = new PlantratamientoJpaController().findPlantratamientoEntities();

                List<Interconsulta> listIntAux = new ArrayList<Interconsulta>();
                List<Remision> listRemAux = new ArrayList<Remision>();
                List<Plantratamiento> listPlanAux = new ArrayList<Plantratamiento>();

                for (int i = 0; i < listInt.size(); i++) {
                    String aux = (String) request.getParameter("interconsulta" + i);

                    if (aux != null && !aux.equals("")) {
                        Interconsulta Iaux = new InterconsultaJpaController().findInterconsulta(Integer.parseInt(aux));
                        listIntAux.add(Iaux);
                    }



                }
                for (int i = 0; i < listRe.size(); i++) {
                    String aux = (String) request.getParameter("remision" + i);
                    if (aux != null && !aux.equals("")) {
                        Remision Raux = new RemisionJpaController().findRemision(Integer.parseInt(aux));
                        listRemAux.add(Raux);
                    }
                }
                for (int i = 0; i < listPlan.size(); i++) {
                    String aux = (String) request.getParameter("plantratamiento" + i);
                    if (aux != null && !aux.equals("")) {
                        Plantratamiento Paux = new PlantratamientoJpaController().findPlantratamiento(Integer.parseInt(aux));
                        listPlanAux.add(Paux);
                    }

                }

                con.setInterconsultaList(listIntAux);
                con.setRemisionList(listRemAux);
                con.setPlantratamientoList(listPlanAux);
                try {
                    new ConsultaJpaController().edit(con);
                } catch (IllegalOrphanException ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                } catch (NonexistentEntityException ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                } catch (Exception ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                }

            }



            if (request.getParameter("action").equals("agregarEvolucion")) {
                HttpSession sesion = request.getSession();
                Consulta con = (Consulta) sesion.getAttribute("consulta");

                String reciboE = (String) request.getParameter("reciboE");
                String tratamientoE = (String) request.getParameter("tratamientoE");
                String codigoTratE = (String) request.getParameter("codigoTratE");

                Tratamiento t = new TratamientoJpaController().findTratamiento(Integer.parseInt(codigoTratE));

                SimpleDateFormat formatoDelTexto = new SimpleDateFormat("yyyy-MM-dd");
                String fechaE = (String) request.getParameter("fechaE");
                Date fecha = null;
                try {

                    fecha = formatoDelTexto.parse(fechaE);

                } catch (ParseException ex) {

                    ex.printStackTrace();

                }

                Evolucion ev = new Evolucion();
                ev.setFecha(fecha);
                ev.setReciboPago(reciboE);
                ev.setTratamientoIdtratamiento(t);
                new EvolucionJpaController().create(ev);


            }



            if (request.getParameter("action").equals("verConsulta")) {
                String idConsulta = (String)request.getParameter("id");
                 Consulta con = new ConsultaJpaController().findConsulta(Integer.parseInt(idConsulta));
                 HttpSession sesion = request.getSession();
                 sesion.setAttribute("consulta", con);
            }
            if (request.getParameter("action").equals("agregarTratamiento")) {
                HttpSession sesion = request.getSession();
                Consulta con = (Consulta) sesion.getAttribute("consulta");
                List<Tratamiento> listT = new ArrayList<Tratamiento>();
                String tratamientosJuntos = (String) request.getParameter("tratamientos");
                if (!tratamientosJuntos.equals("")) {
                    String tratamientos[] = tratamientosJuntos.split(",");

                    for (int i = 0; i < tratamientos.length; i++) {
                        String tra_cod[] = tratamientos[i].split(" - ");
                        String codigo = tra_cod[1];
                        Tratamiento dia = new TratamientoJpaController().findTratamiento(Integer.parseInt(codigo));
                        listT.add(dia);
                    }
                }







                con.setTratamientoList(listT);
                try {
                    new ConsultaJpaController().edit(con);
                } catch (IllegalOrphanException ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                } catch (NonexistentEntityException ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                } catch (Exception ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }



            if (request.getParameter("action").equals("guardarDatosBasicos2")) {
                HttpSession sesion = request.getSession();
                Consulta con = (Consulta) sesion.getAttribute("consulta");
                Examenfisicoestomatologico ex = new Examenfisicoestomatologico();
                ExamenfisicoestomatologicoJpaController conEx = new ExamenfisicoestomatologicoJpaController();
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

                ex.setTemperatura(temperatura);
                ex.setPulso(pulso);
                ex.setTensionArterial(tension);
                ex.setHigieneOral(higiene);
                ex.setSedaDental(usoSeda);
                ex.setCepilloDentalUso(cepillo);
                ex.setVecesAlDia(veces);
                ex.setEnjuagesBsinFluor(enjuages1);
                ex.setEnjuagesBconFluor(enjuages2);
                ex.setHabitosYvicios(habitosYvicios);
                ex.setDatosConsultaiddatosConsulta(con);
                conEx.create(ex);


            }


            if (request.getParameter("action").equals("guardarPron")) {
                HttpSession sesion = request.getSession();
                Consulta con = (Consulta) sesion.getAttribute("consulta");
                List<Remision> listR = (List<Remision>) sesion.getAttribute("remision");
                List<Remision> listR2 = new ArrayList<Remision>();

                for (int i = 0; i < listR.size(); i++) {
                    if (request.getParameter("remision" + i) != null) {
                        Remision remision = listR.get(i);
                        listR2.add(remision);
                    }


                }

                List<Interconsulta> listI = (List<Interconsulta>) sesion.getAttribute("interconsulta");
                List<Interconsulta> listI2 = new ArrayList<Interconsulta>();
                for (int i = 0; i < listI.size(); i++) {
                    if (request.getParameter("interconsulta" + i) != null) {
                        Interconsulta interconsulta = listI.get(i);
                        listI2.add(interconsulta);
                    }
                }
                List<Plantratamiento> listP = (List<Plantratamiento>) sesion.getAttribute("planTratamiento");
                List<Plantratamiento> listP2 = new ArrayList<Plantratamiento>();

                for (int i = 0; i < listP.size(); i++) {
                    if (request.getParameter("plantratamiento" + i) != null) {
                        Plantratamiento plantratamiento = listP.get(i);
                        listP2.add(plantratamiento);
                    }


                }


                String pronostico = (String) request.getParameter("pronostico");
                con.setPronostico(pronostico);
                con.setRemisionList(listR2);
                con.setInterconsultaList(listI2);
                con.setPlantratamientoList(listP2);



                try {
                    new ConsultaJpaController().edit(con);
                } catch (IllegalOrphanException ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                } catch (NonexistentEntityException ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                } catch (Exception ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                }
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
