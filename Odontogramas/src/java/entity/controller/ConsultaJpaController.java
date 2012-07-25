/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package entity.controller;

import conexion.jpaConnection;
import entity.*;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;
import entity.controller.exceptions.IllegalOrphanException;
import entity.controller.exceptions.NonexistentEntityException;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

public class ConsultaJpaController implements Serializable {

    public ConsultaJpaController() {
    }
    
public EntityManager getEntityManager() {
        return jpaConnection.getEntityManager();
    }

    public void create(Consulta consulta) {
        if (consulta.getTratamientoList() == null) {
            consulta.setTratamientoList(new ArrayList<Tratamiento>());
        }
        if (consulta.getDiagnosticoList() == null) {
            consulta.setDiagnosticoList(new ArrayList<Diagnostico>());
        }
        if (consulta.getPlantratamientoList() == null) {
            consulta.setPlantratamientoList(new ArrayList<Plantratamiento>());
        }
        if (consulta.getInterconsultaList() == null) {
            consulta.setInterconsultaList(new ArrayList<Interconsulta>());
        }
        if (consulta.getRemisionList() == null) {
            consulta.setRemisionList(new ArrayList<Remision>());
        }
        if (consulta.getDatosconsultaHasDienteList() == null) {
            consulta.setDatosconsultaHasDienteList(new ArrayList<DatosconsultaHasDiente>());
        }
        if (consulta.getExamenfisicoestomatologicoList() == null) {
            consulta.setExamenfisicoestomatologicoList(new ArrayList<Examenfisicoestomatologico>());
        }
        if (consulta.getRadiografiaList() == null) {
            consulta.setRadiografiaList(new ArrayList<Radiografia>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Docente docenteIddocente = consulta.getDocenteIddocente();
            if (docenteIddocente != null) {
                docenteIddocente = em.getReference(docenteIddocente.getClass(), docenteIddocente.getIddocente());
                consulta.setDocenteIddocente(docenteIddocente);
            }
            Medico medicoIdmedico = consulta.getMedicoIdmedico();
            if (medicoIdmedico != null) {
                medicoIdmedico = em.getReference(medicoIdmedico.getClass(), medicoIdmedico.getIdmedico());
                consulta.setMedicoIdmedico(medicoIdmedico);
            }
            Paciente pacienteIdpersona = consulta.getPacienteIdpersona();
            if (pacienteIdpersona != null) {
                pacienteIdpersona = em.getReference(pacienteIdpersona.getClass(), pacienteIdpersona.getIdpersona());
                consulta.setPacienteIdpersona(pacienteIdpersona);
            }
            List<Tratamiento> attachedTratamientoList = new ArrayList<Tratamiento>();
            for (Tratamiento tratamientoListTratamientoToAttach : consulta.getTratamientoList()) {
                tratamientoListTratamientoToAttach = em.getReference(tratamientoListTratamientoToAttach.getClass(), tratamientoListTratamientoToAttach.getIdtratamiento());
                attachedTratamientoList.add(tratamientoListTratamientoToAttach);
            }
            consulta.setTratamientoList(attachedTratamientoList);
            List<Diagnostico> attachedDiagnosticoList = new ArrayList<Diagnostico>();
            for (Diagnostico diagnosticoListDiagnosticoToAttach : consulta.getDiagnosticoList()) {
                diagnosticoListDiagnosticoToAttach = em.getReference(diagnosticoListDiagnosticoToAttach.getClass(), diagnosticoListDiagnosticoToAttach.getIddiagnostico());
                attachedDiagnosticoList.add(diagnosticoListDiagnosticoToAttach);
            }
            consulta.setDiagnosticoList(attachedDiagnosticoList);
            List<Plantratamiento> attachedPlantratamientoList = new ArrayList<Plantratamiento>();
            for (Plantratamiento plantratamientoListPlantratamientoToAttach : consulta.getPlantratamientoList()) {
                plantratamientoListPlantratamientoToAttach = em.getReference(plantratamientoListPlantratamientoToAttach.getClass(), plantratamientoListPlantratamientoToAttach.getIdplanTratamiento());
                attachedPlantratamientoList.add(plantratamientoListPlantratamientoToAttach);
            }
            consulta.setPlantratamientoList(attachedPlantratamientoList);
            List<Interconsulta> attachedInterconsultaList = new ArrayList<Interconsulta>();
            for (Interconsulta interconsultaListInterconsultaToAttach : consulta.getInterconsultaList()) {
                interconsultaListInterconsultaToAttach = em.getReference(interconsultaListInterconsultaToAttach.getClass(), interconsultaListInterconsultaToAttach.getIdinterconsulta());
                attachedInterconsultaList.add(interconsultaListInterconsultaToAttach);
            }
            consulta.setInterconsultaList(attachedInterconsultaList);
            List<Remision> attachedRemisionList = new ArrayList<Remision>();
            for (Remision remisionListRemisionToAttach : consulta.getRemisionList()) {
                remisionListRemisionToAttach = em.getReference(remisionListRemisionToAttach.getClass(), remisionListRemisionToAttach.getIdremision());
                attachedRemisionList.add(remisionListRemisionToAttach);
            }
            consulta.setRemisionList(attachedRemisionList);
            List<DatosconsultaHasDiente> attachedDatosconsultaHasDienteList = new ArrayList<DatosconsultaHasDiente>();
            for (DatosconsultaHasDiente datosconsultaHasDienteListDatosconsultaHasDienteToAttach : consulta.getDatosconsultaHasDienteList()) {
                datosconsultaHasDienteListDatosconsultaHasDienteToAttach = em.getReference(datosconsultaHasDienteListDatosconsultaHasDienteToAttach.getClass(), datosconsultaHasDienteListDatosconsultaHasDienteToAttach.getDatosconsultaHasDientePK());
                attachedDatosconsultaHasDienteList.add(datosconsultaHasDienteListDatosconsultaHasDienteToAttach);
            }
            consulta.setDatosconsultaHasDienteList(attachedDatosconsultaHasDienteList);
            List<Examenfisicoestomatologico> attachedExamenfisicoestomatologicoList = new ArrayList<Examenfisicoestomatologico>();
            for (Examenfisicoestomatologico examenfisicoestomatologicoListExamenfisicoestomatologicoToAttach : consulta.getExamenfisicoestomatologicoList()) {
                examenfisicoestomatologicoListExamenfisicoestomatologicoToAttach = em.getReference(examenfisicoestomatologicoListExamenfisicoestomatologicoToAttach.getClass(), examenfisicoestomatologicoListExamenfisicoestomatologicoToAttach.getIdexamenFisicoEstomatologico());
                attachedExamenfisicoestomatologicoList.add(examenfisicoestomatologicoListExamenfisicoestomatologicoToAttach);
            }
            consulta.setExamenfisicoestomatologicoList(attachedExamenfisicoestomatologicoList);
            List<Radiografia> attachedRadiografiaList = new ArrayList<Radiografia>();
            for (Radiografia radiografiaListRadiografiaToAttach : consulta.getRadiografiaList()) {
                radiografiaListRadiografiaToAttach = em.getReference(radiografiaListRadiografiaToAttach.getClass(), radiografiaListRadiografiaToAttach.getIdradiografia());
                attachedRadiografiaList.add(radiografiaListRadiografiaToAttach);
            }
            consulta.setRadiografiaList(attachedRadiografiaList);
            em.persist(consulta);
            if (docenteIddocente != null) {
                docenteIddocente.getConsultaList().add(consulta);
                docenteIddocente = em.merge(docenteIddocente);
            }
            if (medicoIdmedico != null) {
                medicoIdmedico.getConsultaList().add(consulta);
                medicoIdmedico = em.merge(medicoIdmedico);
            }
            if (pacienteIdpersona != null) {
                pacienteIdpersona.getConsultaList().add(consulta);
                pacienteIdpersona = em.merge(pacienteIdpersona);
            }
            for (Tratamiento tratamientoListTratamiento : consulta.getTratamientoList()) {
                tratamientoListTratamiento.getConsultaList().add(consulta);
                tratamientoListTratamiento = em.merge(tratamientoListTratamiento);
            }
            for (Diagnostico diagnosticoListDiagnostico : consulta.getDiagnosticoList()) {
                diagnosticoListDiagnostico.getConsultaList().add(consulta);
                diagnosticoListDiagnostico = em.merge(diagnosticoListDiagnostico);
            }
            for (Plantratamiento plantratamientoListPlantratamiento : consulta.getPlantratamientoList()) {
                plantratamientoListPlantratamiento.getConsultaList().add(consulta);
                plantratamientoListPlantratamiento = em.merge(plantratamientoListPlantratamiento);
            }
            for (Interconsulta interconsultaListInterconsulta : consulta.getInterconsultaList()) {
                interconsultaListInterconsulta.getConsultaList().add(consulta);
                interconsultaListInterconsulta = em.merge(interconsultaListInterconsulta);
            }
            for (Remision remisionListRemision : consulta.getRemisionList()) {
                remisionListRemision.getConsultaList().add(consulta);
                remisionListRemision = em.merge(remisionListRemision);
            }
            for (DatosconsultaHasDiente datosconsultaHasDienteListDatosconsultaHasDiente : consulta.getDatosconsultaHasDienteList()) {
                Consulta oldConsultaOfDatosconsultaHasDienteListDatosconsultaHasDiente = datosconsultaHasDienteListDatosconsultaHasDiente.getConsulta();
                datosconsultaHasDienteListDatosconsultaHasDiente.setConsulta(consulta);
                datosconsultaHasDienteListDatosconsultaHasDiente = em.merge(datosconsultaHasDienteListDatosconsultaHasDiente);
                if (oldConsultaOfDatosconsultaHasDienteListDatosconsultaHasDiente != null) {
                    oldConsultaOfDatosconsultaHasDienteListDatosconsultaHasDiente.getDatosconsultaHasDienteList().remove(datosconsultaHasDienteListDatosconsultaHasDiente);
                    oldConsultaOfDatosconsultaHasDienteListDatosconsultaHasDiente = em.merge(oldConsultaOfDatosconsultaHasDienteListDatosconsultaHasDiente);
                }
            }
            for (Examenfisicoestomatologico examenfisicoestomatologicoListExamenfisicoestomatologico : consulta.getExamenfisicoestomatologicoList()) {
                Consulta oldDatosConsultaiddatosConsultaOfExamenfisicoestomatologicoListExamenfisicoestomatologico = examenfisicoestomatologicoListExamenfisicoestomatologico.getDatosConsultaiddatosConsulta();
                examenfisicoestomatologicoListExamenfisicoestomatologico.setDatosConsultaiddatosConsulta(consulta);
                examenfisicoestomatologicoListExamenfisicoestomatologico = em.merge(examenfisicoestomatologicoListExamenfisicoestomatologico);
                if (oldDatosConsultaiddatosConsultaOfExamenfisicoestomatologicoListExamenfisicoestomatologico != null) {
                    oldDatosConsultaiddatosConsultaOfExamenfisicoestomatologicoListExamenfisicoestomatologico.getExamenfisicoestomatologicoList().remove(examenfisicoestomatologicoListExamenfisicoestomatologico);
                    oldDatosConsultaiddatosConsultaOfExamenfisicoestomatologicoListExamenfisicoestomatologico = em.merge(oldDatosConsultaiddatosConsultaOfExamenfisicoestomatologicoListExamenfisicoestomatologico);
                }
            }
            for (Radiografia radiografiaListRadiografia : consulta.getRadiografiaList()) {
                Consulta oldDatosConsultaiddatosConsultaOfRadiografiaListRadiografia = radiografiaListRadiografia.getDatosConsultaiddatosConsulta();
                radiografiaListRadiografia.setDatosConsultaiddatosConsulta(consulta);
                radiografiaListRadiografia = em.merge(radiografiaListRadiografia);
                if (oldDatosConsultaiddatosConsultaOfRadiografiaListRadiografia != null) {
                    oldDatosConsultaiddatosConsultaOfRadiografiaListRadiografia.getRadiografiaList().remove(radiografiaListRadiografia);
                    oldDatosConsultaiddatosConsultaOfRadiografiaListRadiografia = em.merge(oldDatosConsultaiddatosConsultaOfRadiografiaListRadiografia);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Consulta consulta) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Consulta persistentConsulta = em.find(Consulta.class, consulta.getIddatosConsulta());
            Docente docenteIddocenteOld = persistentConsulta.getDocenteIddocente();
            Docente docenteIddocenteNew = consulta.getDocenteIddocente();
            Medico medicoIdmedicoOld = persistentConsulta.getMedicoIdmedico();
            Medico medicoIdmedicoNew = consulta.getMedicoIdmedico();
            Paciente pacienteIdpersonaOld = persistentConsulta.getPacienteIdpersona();
            Paciente pacienteIdpersonaNew = consulta.getPacienteIdpersona();
            List<Tratamiento> tratamientoListOld = persistentConsulta.getTratamientoList();
            List<Tratamiento> tratamientoListNew = consulta.getTratamientoList();
            List<Diagnostico> diagnosticoListOld = persistentConsulta.getDiagnosticoList();
            List<Diagnostico> diagnosticoListNew = consulta.getDiagnosticoList();
            List<Plantratamiento> plantratamientoListOld = persistentConsulta.getPlantratamientoList();
            List<Plantratamiento> plantratamientoListNew = consulta.getPlantratamientoList();
            List<Interconsulta> interconsultaListOld = persistentConsulta.getInterconsultaList();
            List<Interconsulta> interconsultaListNew = consulta.getInterconsultaList();
            List<Remision> remisionListOld = persistentConsulta.getRemisionList();
            List<Remision> remisionListNew = consulta.getRemisionList();
            List<DatosconsultaHasDiente> datosconsultaHasDienteListOld = persistentConsulta.getDatosconsultaHasDienteList();
            List<DatosconsultaHasDiente> datosconsultaHasDienteListNew = consulta.getDatosconsultaHasDienteList();
            List<Examenfisicoestomatologico> examenfisicoestomatologicoListOld = persistentConsulta.getExamenfisicoestomatologicoList();
            List<Examenfisicoestomatologico> examenfisicoestomatologicoListNew = consulta.getExamenfisicoestomatologicoList();
            List<Radiografia> radiografiaListOld = persistentConsulta.getRadiografiaList();
            List<Radiografia> radiografiaListNew = consulta.getRadiografiaList();
            List<String> illegalOrphanMessages = null;
            for (DatosconsultaHasDiente datosconsultaHasDienteListOldDatosconsultaHasDiente : datosconsultaHasDienteListOld) {
                if (!datosconsultaHasDienteListNew.contains(datosconsultaHasDienteListOldDatosconsultaHasDiente)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain DatosconsultaHasDiente " + datosconsultaHasDienteListOldDatosconsultaHasDiente + " since its consulta field is not nullable.");
                }
            }
            for (Examenfisicoestomatologico examenfisicoestomatologicoListOldExamenfisicoestomatologico : examenfisicoestomatologicoListOld) {
                if (!examenfisicoestomatologicoListNew.contains(examenfisicoestomatologicoListOldExamenfisicoestomatologico)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Examenfisicoestomatologico " + examenfisicoestomatologicoListOldExamenfisicoestomatologico + " since its datosConsultaiddatosConsulta field is not nullable.");
                }
            }
            for (Radiografia radiografiaListOldRadiografia : radiografiaListOld) {
                if (!radiografiaListNew.contains(radiografiaListOldRadiografia)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Radiografia " + radiografiaListOldRadiografia + " since its datosConsultaiddatosConsulta field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            if (docenteIddocenteNew != null) {
                docenteIddocenteNew = em.getReference(docenteIddocenteNew.getClass(), docenteIddocenteNew.getIddocente());
                consulta.setDocenteIddocente(docenteIddocenteNew);
            }
            if (medicoIdmedicoNew != null) {
                medicoIdmedicoNew = em.getReference(medicoIdmedicoNew.getClass(), medicoIdmedicoNew.getIdmedico());
                consulta.setMedicoIdmedico(medicoIdmedicoNew);
            }
            if (pacienteIdpersonaNew != null) {
                pacienteIdpersonaNew = em.getReference(pacienteIdpersonaNew.getClass(), pacienteIdpersonaNew.getIdpersona());
                consulta.setPacienteIdpersona(pacienteIdpersonaNew);
            }
            List<Tratamiento> attachedTratamientoListNew = new ArrayList<Tratamiento>();
            for (Tratamiento tratamientoListNewTratamientoToAttach : tratamientoListNew) {
                tratamientoListNewTratamientoToAttach = em.getReference(tratamientoListNewTratamientoToAttach.getClass(), tratamientoListNewTratamientoToAttach.getIdtratamiento());
                attachedTratamientoListNew.add(tratamientoListNewTratamientoToAttach);
            }
            tratamientoListNew = attachedTratamientoListNew;
            consulta.setTratamientoList(tratamientoListNew);
            List<Diagnostico> attachedDiagnosticoListNew = new ArrayList<Diagnostico>();
            for (Diagnostico diagnosticoListNewDiagnosticoToAttach : diagnosticoListNew) {
                diagnosticoListNewDiagnosticoToAttach = em.getReference(diagnosticoListNewDiagnosticoToAttach.getClass(), diagnosticoListNewDiagnosticoToAttach.getIddiagnostico());
                attachedDiagnosticoListNew.add(diagnosticoListNewDiagnosticoToAttach);
            }
            diagnosticoListNew = attachedDiagnosticoListNew;
            consulta.setDiagnosticoList(diagnosticoListNew);
            List<Plantratamiento> attachedPlantratamientoListNew = new ArrayList<Plantratamiento>();
            for (Plantratamiento plantratamientoListNewPlantratamientoToAttach : plantratamientoListNew) {
                plantratamientoListNewPlantratamientoToAttach = em.getReference(plantratamientoListNewPlantratamientoToAttach.getClass(), plantratamientoListNewPlantratamientoToAttach.getIdplanTratamiento());
                attachedPlantratamientoListNew.add(plantratamientoListNewPlantratamientoToAttach);
            }
            plantratamientoListNew = attachedPlantratamientoListNew;
            consulta.setPlantratamientoList(plantratamientoListNew);
            List<Interconsulta> attachedInterconsultaListNew = new ArrayList<Interconsulta>();
            for (Interconsulta interconsultaListNewInterconsultaToAttach : interconsultaListNew) {
                interconsultaListNewInterconsultaToAttach = em.getReference(interconsultaListNewInterconsultaToAttach.getClass(), interconsultaListNewInterconsultaToAttach.getIdinterconsulta());
                attachedInterconsultaListNew.add(interconsultaListNewInterconsultaToAttach);
            }
            interconsultaListNew = attachedInterconsultaListNew;
            consulta.setInterconsultaList(interconsultaListNew);
            List<Remision> attachedRemisionListNew = new ArrayList<Remision>();
            for (Remision remisionListNewRemisionToAttach : remisionListNew) {
                remisionListNewRemisionToAttach = em.getReference(remisionListNewRemisionToAttach.getClass(), remisionListNewRemisionToAttach.getIdremision());
                attachedRemisionListNew.add(remisionListNewRemisionToAttach);
            }
            remisionListNew = attachedRemisionListNew;
            consulta.setRemisionList(remisionListNew);
            List<DatosconsultaHasDiente> attachedDatosconsultaHasDienteListNew = new ArrayList<DatosconsultaHasDiente>();
            for (DatosconsultaHasDiente datosconsultaHasDienteListNewDatosconsultaHasDienteToAttach : datosconsultaHasDienteListNew) {
                datosconsultaHasDienteListNewDatosconsultaHasDienteToAttach = em.getReference(datosconsultaHasDienteListNewDatosconsultaHasDienteToAttach.getClass(), datosconsultaHasDienteListNewDatosconsultaHasDienteToAttach.getDatosconsultaHasDientePK());
                attachedDatosconsultaHasDienteListNew.add(datosconsultaHasDienteListNewDatosconsultaHasDienteToAttach);
            }
            datosconsultaHasDienteListNew = attachedDatosconsultaHasDienteListNew;
            consulta.setDatosconsultaHasDienteList(datosconsultaHasDienteListNew);
            List<Examenfisicoestomatologico> attachedExamenfisicoestomatologicoListNew = new ArrayList<Examenfisicoestomatologico>();
            for (Examenfisicoestomatologico examenfisicoestomatologicoListNewExamenfisicoestomatologicoToAttach : examenfisicoestomatologicoListNew) {
                examenfisicoestomatologicoListNewExamenfisicoestomatologicoToAttach = em.getReference(examenfisicoestomatologicoListNewExamenfisicoestomatologicoToAttach.getClass(), examenfisicoestomatologicoListNewExamenfisicoestomatologicoToAttach.getIdexamenFisicoEstomatologico());
                attachedExamenfisicoestomatologicoListNew.add(examenfisicoestomatologicoListNewExamenfisicoestomatologicoToAttach);
            }
            examenfisicoestomatologicoListNew = attachedExamenfisicoestomatologicoListNew;
            consulta.setExamenfisicoestomatologicoList(examenfisicoestomatologicoListNew);
            List<Radiografia> attachedRadiografiaListNew = new ArrayList<Radiografia>();
            for (Radiografia radiografiaListNewRadiografiaToAttach : radiografiaListNew) {
                radiografiaListNewRadiografiaToAttach = em.getReference(radiografiaListNewRadiografiaToAttach.getClass(), radiografiaListNewRadiografiaToAttach.getIdradiografia());
                attachedRadiografiaListNew.add(radiografiaListNewRadiografiaToAttach);
            }
            radiografiaListNew = attachedRadiografiaListNew;
            consulta.setRadiografiaList(radiografiaListNew);
            consulta = em.merge(consulta);
            if (docenteIddocenteOld != null && !docenteIddocenteOld.equals(docenteIddocenteNew)) {
                docenteIddocenteOld.getConsultaList().remove(consulta);
                docenteIddocenteOld = em.merge(docenteIddocenteOld);
            }
            if (docenteIddocenteNew != null && !docenteIddocenteNew.equals(docenteIddocenteOld)) {
                docenteIddocenteNew.getConsultaList().add(consulta);
                docenteIddocenteNew = em.merge(docenteIddocenteNew);
            }
            if (medicoIdmedicoOld != null && !medicoIdmedicoOld.equals(medicoIdmedicoNew)) {
                medicoIdmedicoOld.getConsultaList().remove(consulta);
                medicoIdmedicoOld = em.merge(medicoIdmedicoOld);
            }
            if (medicoIdmedicoNew != null && !medicoIdmedicoNew.equals(medicoIdmedicoOld)) {
                medicoIdmedicoNew.getConsultaList().add(consulta);
                medicoIdmedicoNew = em.merge(medicoIdmedicoNew);
            }
            if (pacienteIdpersonaOld != null && !pacienteIdpersonaOld.equals(pacienteIdpersonaNew)) {
                pacienteIdpersonaOld.getConsultaList().remove(consulta);
                pacienteIdpersonaOld = em.merge(pacienteIdpersonaOld);
            }
            if (pacienteIdpersonaNew != null && !pacienteIdpersonaNew.equals(pacienteIdpersonaOld)) {
                pacienteIdpersonaNew.getConsultaList().add(consulta);
                pacienteIdpersonaNew = em.merge(pacienteIdpersonaNew);
            }
            for (Tratamiento tratamientoListOldTratamiento : tratamientoListOld) {
                if (!tratamientoListNew.contains(tratamientoListOldTratamiento)) {
                    tratamientoListOldTratamiento.getConsultaList().remove(consulta);
                    tratamientoListOldTratamiento = em.merge(tratamientoListOldTratamiento);
                }
            }
            for (Tratamiento tratamientoListNewTratamiento : tratamientoListNew) {
                if (!tratamientoListOld.contains(tratamientoListNewTratamiento)) {
                    tratamientoListNewTratamiento.getConsultaList().add(consulta);
                    tratamientoListNewTratamiento = em.merge(tratamientoListNewTratamiento);
                }
            }
            for (Diagnostico diagnosticoListOldDiagnostico : diagnosticoListOld) {
                if (!diagnosticoListNew.contains(diagnosticoListOldDiagnostico)) {
                    diagnosticoListOldDiagnostico.getConsultaList().remove(consulta);
                    diagnosticoListOldDiagnostico = em.merge(diagnosticoListOldDiagnostico);
                }
            }
            for (Diagnostico diagnosticoListNewDiagnostico : diagnosticoListNew) {
                if (!diagnosticoListOld.contains(diagnosticoListNewDiagnostico)) {
                    diagnosticoListNewDiagnostico.getConsultaList().add(consulta);
                    diagnosticoListNewDiagnostico = em.merge(diagnosticoListNewDiagnostico);
                }
            }
            for (Plantratamiento plantratamientoListOldPlantratamiento : plantratamientoListOld) {
                if (!plantratamientoListNew.contains(plantratamientoListOldPlantratamiento)) {
                    plantratamientoListOldPlantratamiento.getConsultaList().remove(consulta);
                    plantratamientoListOldPlantratamiento = em.merge(plantratamientoListOldPlantratamiento);
                }
            }
            for (Plantratamiento plantratamientoListNewPlantratamiento : plantratamientoListNew) {
                if (!plantratamientoListOld.contains(plantratamientoListNewPlantratamiento)) {
                    plantratamientoListNewPlantratamiento.getConsultaList().add(consulta);
                    plantratamientoListNewPlantratamiento = em.merge(plantratamientoListNewPlantratamiento);
                }
            }
            for (Interconsulta interconsultaListOldInterconsulta : interconsultaListOld) {
                if (!interconsultaListNew.contains(interconsultaListOldInterconsulta)) {
                    interconsultaListOldInterconsulta.getConsultaList().remove(consulta);
                    interconsultaListOldInterconsulta = em.merge(interconsultaListOldInterconsulta);
                }
            }
            for (Interconsulta interconsultaListNewInterconsulta : interconsultaListNew) {
                if (!interconsultaListOld.contains(interconsultaListNewInterconsulta)) {
                    interconsultaListNewInterconsulta.getConsultaList().add(consulta);
                    interconsultaListNewInterconsulta = em.merge(interconsultaListNewInterconsulta);
                }
            }
            for (Remision remisionListOldRemision : remisionListOld) {
                if (!remisionListNew.contains(remisionListOldRemision)) {
                    remisionListOldRemision.getConsultaList().remove(consulta);
                    remisionListOldRemision = em.merge(remisionListOldRemision);
                }
            }
            for (Remision remisionListNewRemision : remisionListNew) {
                if (!remisionListOld.contains(remisionListNewRemision)) {
                    remisionListNewRemision.getConsultaList().add(consulta);
                    remisionListNewRemision = em.merge(remisionListNewRemision);
                }
            }
            for (DatosconsultaHasDiente datosconsultaHasDienteListNewDatosconsultaHasDiente : datosconsultaHasDienteListNew) {
                if (!datosconsultaHasDienteListOld.contains(datosconsultaHasDienteListNewDatosconsultaHasDiente)) {
                    Consulta oldConsultaOfDatosconsultaHasDienteListNewDatosconsultaHasDiente = datosconsultaHasDienteListNewDatosconsultaHasDiente.getConsulta();
                    datosconsultaHasDienteListNewDatosconsultaHasDiente.setConsulta(consulta);
                    datosconsultaHasDienteListNewDatosconsultaHasDiente = em.merge(datosconsultaHasDienteListNewDatosconsultaHasDiente);
                    if (oldConsultaOfDatosconsultaHasDienteListNewDatosconsultaHasDiente != null && !oldConsultaOfDatosconsultaHasDienteListNewDatosconsultaHasDiente.equals(consulta)) {
                        oldConsultaOfDatosconsultaHasDienteListNewDatosconsultaHasDiente.getDatosconsultaHasDienteList().remove(datosconsultaHasDienteListNewDatosconsultaHasDiente);
                        oldConsultaOfDatosconsultaHasDienteListNewDatosconsultaHasDiente = em.merge(oldConsultaOfDatosconsultaHasDienteListNewDatosconsultaHasDiente);
                    }
                }
            }
            for (Examenfisicoestomatologico examenfisicoestomatologicoListNewExamenfisicoestomatologico : examenfisicoestomatologicoListNew) {
                if (!examenfisicoestomatologicoListOld.contains(examenfisicoestomatologicoListNewExamenfisicoestomatologico)) {
                    Consulta oldDatosConsultaiddatosConsultaOfExamenfisicoestomatologicoListNewExamenfisicoestomatologico = examenfisicoestomatologicoListNewExamenfisicoestomatologico.getDatosConsultaiddatosConsulta();
                    examenfisicoestomatologicoListNewExamenfisicoestomatologico.setDatosConsultaiddatosConsulta(consulta);
                    examenfisicoestomatologicoListNewExamenfisicoestomatologico = em.merge(examenfisicoestomatologicoListNewExamenfisicoestomatologico);
                    if (oldDatosConsultaiddatosConsultaOfExamenfisicoestomatologicoListNewExamenfisicoestomatologico != null && !oldDatosConsultaiddatosConsultaOfExamenfisicoestomatologicoListNewExamenfisicoestomatologico.equals(consulta)) {
                        oldDatosConsultaiddatosConsultaOfExamenfisicoestomatologicoListNewExamenfisicoestomatologico.getExamenfisicoestomatologicoList().remove(examenfisicoestomatologicoListNewExamenfisicoestomatologico);
                        oldDatosConsultaiddatosConsultaOfExamenfisicoestomatologicoListNewExamenfisicoestomatologico = em.merge(oldDatosConsultaiddatosConsultaOfExamenfisicoestomatologicoListNewExamenfisicoestomatologico);
                    }
                }
            }
            for (Radiografia radiografiaListNewRadiografia : radiografiaListNew) {
                if (!radiografiaListOld.contains(radiografiaListNewRadiografia)) {
                    Consulta oldDatosConsultaiddatosConsultaOfRadiografiaListNewRadiografia = radiografiaListNewRadiografia.getDatosConsultaiddatosConsulta();
                    radiografiaListNewRadiografia.setDatosConsultaiddatosConsulta(consulta);
                    radiografiaListNewRadiografia = em.merge(radiografiaListNewRadiografia);
                    if (oldDatosConsultaiddatosConsultaOfRadiografiaListNewRadiografia != null && !oldDatosConsultaiddatosConsultaOfRadiografiaListNewRadiografia.equals(consulta)) {
                        oldDatosConsultaiddatosConsultaOfRadiografiaListNewRadiografia.getRadiografiaList().remove(radiografiaListNewRadiografia);
                        oldDatosConsultaiddatosConsultaOfRadiografiaListNewRadiografia = em.merge(oldDatosConsultaiddatosConsultaOfRadiografiaListNewRadiografia);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = consulta.getIddatosConsulta();
                if (findConsulta(id) == null) {
                    throw new NonexistentEntityException("The consulta with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Integer id) throws IllegalOrphanException, NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Consulta consulta;
            try {
                consulta = em.getReference(Consulta.class, id);
                consulta.getIddatosConsulta();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The consulta with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<DatosconsultaHasDiente> datosconsultaHasDienteListOrphanCheck = consulta.getDatosconsultaHasDienteList();
            for (DatosconsultaHasDiente datosconsultaHasDienteListOrphanCheckDatosconsultaHasDiente : datosconsultaHasDienteListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Consulta (" + consulta + ") cannot be destroyed since the DatosconsultaHasDiente " + datosconsultaHasDienteListOrphanCheckDatosconsultaHasDiente + " in its datosconsultaHasDienteList field has a non-nullable consulta field.");
            }
            List<Examenfisicoestomatologico> examenfisicoestomatologicoListOrphanCheck = consulta.getExamenfisicoestomatologicoList();
            for (Examenfisicoestomatologico examenfisicoestomatologicoListOrphanCheckExamenfisicoestomatologico : examenfisicoestomatologicoListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Consulta (" + consulta + ") cannot be destroyed since the Examenfisicoestomatologico " + examenfisicoestomatologicoListOrphanCheckExamenfisicoestomatologico + " in its examenfisicoestomatologicoList field has a non-nullable datosConsultaiddatosConsulta field.");
            }
            List<Radiografia> radiografiaListOrphanCheck = consulta.getRadiografiaList();
            for (Radiografia radiografiaListOrphanCheckRadiografia : radiografiaListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Consulta (" + consulta + ") cannot be destroyed since the Radiografia " + radiografiaListOrphanCheckRadiografia + " in its radiografiaList field has a non-nullable datosConsultaiddatosConsulta field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            Docente docenteIddocente = consulta.getDocenteIddocente();
            if (docenteIddocente != null) {
                docenteIddocente.getConsultaList().remove(consulta);
                docenteIddocente = em.merge(docenteIddocente);
            }
            Medico medicoIdmedico = consulta.getMedicoIdmedico();
            if (medicoIdmedico != null) {
                medicoIdmedico.getConsultaList().remove(consulta);
                medicoIdmedico = em.merge(medicoIdmedico);
            }
            Paciente pacienteIdpersona = consulta.getPacienteIdpersona();
            if (pacienteIdpersona != null) {
                pacienteIdpersona.getConsultaList().remove(consulta);
                pacienteIdpersona = em.merge(pacienteIdpersona);
            }
            List<Tratamiento> tratamientoList = consulta.getTratamientoList();
            for (Tratamiento tratamientoListTratamiento : tratamientoList) {
                tratamientoListTratamiento.getConsultaList().remove(consulta);
                tratamientoListTratamiento = em.merge(tratamientoListTratamiento);
            }
            List<Diagnostico> diagnosticoList = consulta.getDiagnosticoList();
            for (Diagnostico diagnosticoListDiagnostico : diagnosticoList) {
                diagnosticoListDiagnostico.getConsultaList().remove(consulta);
                diagnosticoListDiagnostico = em.merge(diagnosticoListDiagnostico);
            }
            List<Plantratamiento> plantratamientoList = consulta.getPlantratamientoList();
            for (Plantratamiento plantratamientoListPlantratamiento : plantratamientoList) {
                plantratamientoListPlantratamiento.getConsultaList().remove(consulta);
                plantratamientoListPlantratamiento = em.merge(plantratamientoListPlantratamiento);
            }
            List<Interconsulta> interconsultaList = consulta.getInterconsultaList();
            for (Interconsulta interconsultaListInterconsulta : interconsultaList) {
                interconsultaListInterconsulta.getConsultaList().remove(consulta);
                interconsultaListInterconsulta = em.merge(interconsultaListInterconsulta);
            }
            List<Remision> remisionList = consulta.getRemisionList();
            for (Remision remisionListRemision : remisionList) {
                remisionListRemision.getConsultaList().remove(consulta);
                remisionListRemision = em.merge(remisionListRemision);
            }
            em.remove(consulta);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Consulta> findConsultaEntities() {
        return findConsultaEntities(true, -1, -1);
    }

    public List<Consulta> findConsultaEntities(int maxResults, int firstResult) {
        return findConsultaEntities(false, maxResults, firstResult);
    }

    private List<Consulta> findConsultaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Consulta.class));
            Query q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public Consulta findConsulta(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Consulta.class, id);
        } finally {
            em.close();
        }
    }

    public int getConsultaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Consulta> rt = cq.from(Consulta.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
}
