/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package entity.controller;

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

/**
 *
 * @author Oscar
 */
public class DatosconsultaJpaController implements Serializable {

    public DatosconsultaJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Datosconsulta datosconsulta) {
        if (datosconsulta.getTratamientoList() == null) {
            datosconsulta.setTratamientoList(new ArrayList<Tratamiento>());
        }
        if (datosconsulta.getDiagnosticoList() == null) {
            datosconsulta.setDiagnosticoList(new ArrayList<Diagnostico>());
        }
        if (datosconsulta.getPlantratamientoList() == null) {
            datosconsulta.setPlantratamientoList(new ArrayList<Plantratamiento>());
        }
        if (datosconsulta.getDatosconsultaHasDienteList() == null) {
            datosconsulta.setDatosconsultaHasDienteList(new ArrayList<DatosconsultaHasDiente>());
        }
        if (datosconsulta.getExamenfisicoestomatologicoList() == null) {
            datosconsulta.setExamenfisicoestomatologicoList(new ArrayList<Examenfisicoestomatologico>());
        }
        if (datosconsulta.getRadiografiaList() == null) {
            datosconsulta.setRadiografiaList(new ArrayList<Radiografia>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Medico medicoIdmedico = datosconsulta.getMedicoIdmedico();
            if (medicoIdmedico != null) {
                medicoIdmedico = em.getReference(medicoIdmedico.getClass(), medicoIdmedico.getIdmedico());
                datosconsulta.setMedicoIdmedico(medicoIdmedico);
            }
            Paciente pacienteIdpersona = datosconsulta.getPacienteIdpersona();
            if (pacienteIdpersona != null) {
                pacienteIdpersona = em.getReference(pacienteIdpersona.getClass(), pacienteIdpersona.getIdpersona());
                datosconsulta.setPacienteIdpersona(pacienteIdpersona);
            }
            List<Tratamiento> attachedTratamientoList = new ArrayList<Tratamiento>();
            for (Tratamiento tratamientoListTratamientoToAttach : datosconsulta.getTratamientoList()) {
                tratamientoListTratamientoToAttach = em.getReference(tratamientoListTratamientoToAttach.getClass(), tratamientoListTratamientoToAttach.getIdtratamiento());
                attachedTratamientoList.add(tratamientoListTratamientoToAttach);
            }
            datosconsulta.setTratamientoList(attachedTratamientoList);
            List<Diagnostico> attachedDiagnosticoList = new ArrayList<Diagnostico>();
            for (Diagnostico diagnosticoListDiagnosticoToAttach : datosconsulta.getDiagnosticoList()) {
                diagnosticoListDiagnosticoToAttach = em.getReference(diagnosticoListDiagnosticoToAttach.getClass(), diagnosticoListDiagnosticoToAttach.getIddiagnostico());
                attachedDiagnosticoList.add(diagnosticoListDiagnosticoToAttach);
            }
            datosconsulta.setDiagnosticoList(attachedDiagnosticoList);
            List<Plantratamiento> attachedPlantratamientoList = new ArrayList<Plantratamiento>();
            for (Plantratamiento plantratamientoListPlantratamientoToAttach : datosconsulta.getPlantratamientoList()) {
                plantratamientoListPlantratamientoToAttach = em.getReference(plantratamientoListPlantratamientoToAttach.getClass(), plantratamientoListPlantratamientoToAttach.getIdplanTratamiento());
                attachedPlantratamientoList.add(plantratamientoListPlantratamientoToAttach);
            }
            datosconsulta.setPlantratamientoList(attachedPlantratamientoList);
            List<DatosconsultaHasDiente> attachedDatosconsultaHasDienteList = new ArrayList<DatosconsultaHasDiente>();
            for (DatosconsultaHasDiente datosconsultaHasDienteListDatosconsultaHasDienteToAttach : datosconsulta.getDatosconsultaHasDienteList()) {
                datosconsultaHasDienteListDatosconsultaHasDienteToAttach = em.getReference(datosconsultaHasDienteListDatosconsultaHasDienteToAttach.getClass(), datosconsultaHasDienteListDatosconsultaHasDienteToAttach.getDatosconsultaHasDientePK());
                attachedDatosconsultaHasDienteList.add(datosconsultaHasDienteListDatosconsultaHasDienteToAttach);
            }
            datosconsulta.setDatosconsultaHasDienteList(attachedDatosconsultaHasDienteList);
            List<Examenfisicoestomatologico> attachedExamenfisicoestomatologicoList = new ArrayList<Examenfisicoestomatologico>();
            for (Examenfisicoestomatologico examenfisicoestomatologicoListExamenfisicoestomatologicoToAttach : datosconsulta.getExamenfisicoestomatologicoList()) {
                examenfisicoestomatologicoListExamenfisicoestomatologicoToAttach = em.getReference(examenfisicoestomatologicoListExamenfisicoestomatologicoToAttach.getClass(), examenfisicoestomatologicoListExamenfisicoestomatologicoToAttach.getIdexamenFisicoEstomatologico());
                attachedExamenfisicoestomatologicoList.add(examenfisicoestomatologicoListExamenfisicoestomatologicoToAttach);
            }
            datosconsulta.setExamenfisicoestomatologicoList(attachedExamenfisicoestomatologicoList);
            List<Radiografia> attachedRadiografiaList = new ArrayList<Radiografia>();
            for (Radiografia radiografiaListRadiografiaToAttach : datosconsulta.getRadiografiaList()) {
                radiografiaListRadiografiaToAttach = em.getReference(radiografiaListRadiografiaToAttach.getClass(), radiografiaListRadiografiaToAttach.getIdradiografia());
                attachedRadiografiaList.add(radiografiaListRadiografiaToAttach);
            }
            datosconsulta.setRadiografiaList(attachedRadiografiaList);
            em.persist(datosconsulta);
            if (medicoIdmedico != null) {
                medicoIdmedico.getDatosconsultaList().add(datosconsulta);
                medicoIdmedico = em.merge(medicoIdmedico);
            }
            if (pacienteIdpersona != null) {
                pacienteIdpersona.getDatosconsultaList().add(datosconsulta);
                pacienteIdpersona = em.merge(pacienteIdpersona);
            }
            for (Tratamiento tratamientoListTratamiento : datosconsulta.getTratamientoList()) {
                tratamientoListTratamiento.getDatosconsultaList().add(datosconsulta);
                tratamientoListTratamiento = em.merge(tratamientoListTratamiento);
            }
            for (Diagnostico diagnosticoListDiagnostico : datosconsulta.getDiagnosticoList()) {
                diagnosticoListDiagnostico.getDatosconsultaList().add(datosconsulta);
                diagnosticoListDiagnostico = em.merge(diagnosticoListDiagnostico);
            }
            for (Plantratamiento plantratamientoListPlantratamiento : datosconsulta.getPlantratamientoList()) {
                plantratamientoListPlantratamiento.getDatosconsultaList().add(datosconsulta);
                plantratamientoListPlantratamiento = em.merge(plantratamientoListPlantratamiento);
            }
            for (DatosconsultaHasDiente datosconsultaHasDienteListDatosconsultaHasDiente : datosconsulta.getDatosconsultaHasDienteList()) {
                Datosconsulta oldDatosconsultaOfDatosconsultaHasDienteListDatosconsultaHasDiente = datosconsultaHasDienteListDatosconsultaHasDiente.getDatosconsulta();
                datosconsultaHasDienteListDatosconsultaHasDiente.setDatosconsulta(datosconsulta);
                datosconsultaHasDienteListDatosconsultaHasDiente = em.merge(datosconsultaHasDienteListDatosconsultaHasDiente);
                if (oldDatosconsultaOfDatosconsultaHasDienteListDatosconsultaHasDiente != null) {
                    oldDatosconsultaOfDatosconsultaHasDienteListDatosconsultaHasDiente.getDatosconsultaHasDienteList().remove(datosconsultaHasDienteListDatosconsultaHasDiente);
                    oldDatosconsultaOfDatosconsultaHasDienteListDatosconsultaHasDiente = em.merge(oldDatosconsultaOfDatosconsultaHasDienteListDatosconsultaHasDiente);
                }
            }
            for (Examenfisicoestomatologico examenfisicoestomatologicoListExamenfisicoestomatologico : datosconsulta.getExamenfisicoestomatologicoList()) {
                Datosconsulta oldDatosConsultaiddatosConsultaOfExamenfisicoestomatologicoListExamenfisicoestomatologico = examenfisicoestomatologicoListExamenfisicoestomatologico.getDatosConsultaiddatosConsulta();
                examenfisicoestomatologicoListExamenfisicoestomatologico.setDatosConsultaiddatosConsulta(datosconsulta);
                examenfisicoestomatologicoListExamenfisicoestomatologico = em.merge(examenfisicoestomatologicoListExamenfisicoestomatologico);
                if (oldDatosConsultaiddatosConsultaOfExamenfisicoestomatologicoListExamenfisicoestomatologico != null) {
                    oldDatosConsultaiddatosConsultaOfExamenfisicoestomatologicoListExamenfisicoestomatologico.getExamenfisicoestomatologicoList().remove(examenfisicoestomatologicoListExamenfisicoestomatologico);
                    oldDatosConsultaiddatosConsultaOfExamenfisicoestomatologicoListExamenfisicoestomatologico = em.merge(oldDatosConsultaiddatosConsultaOfExamenfisicoestomatologicoListExamenfisicoestomatologico);
                }
            }
            for (Radiografia radiografiaListRadiografia : datosconsulta.getRadiografiaList()) {
                Datosconsulta oldDatosConsultaiddatosConsultaOfRadiografiaListRadiografia = radiografiaListRadiografia.getDatosConsultaiddatosConsulta();
                radiografiaListRadiografia.setDatosConsultaiddatosConsulta(datosconsulta);
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

    public void edit(Datosconsulta datosconsulta) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Datosconsulta persistentDatosconsulta = em.find(Datosconsulta.class, datosconsulta.getIddatosConsulta());
            Medico medicoIdmedicoOld = persistentDatosconsulta.getMedicoIdmedico();
            Medico medicoIdmedicoNew = datosconsulta.getMedicoIdmedico();
            Paciente pacienteIdpersonaOld = persistentDatosconsulta.getPacienteIdpersona();
            Paciente pacienteIdpersonaNew = datosconsulta.getPacienteIdpersona();
            List<Tratamiento> tratamientoListOld = persistentDatosconsulta.getTratamientoList();
            List<Tratamiento> tratamientoListNew = datosconsulta.getTratamientoList();
            List<Diagnostico> diagnosticoListOld = persistentDatosconsulta.getDiagnosticoList();
            List<Diagnostico> diagnosticoListNew = datosconsulta.getDiagnosticoList();
            List<Plantratamiento> plantratamientoListOld = persistentDatosconsulta.getPlantratamientoList();
            List<Plantratamiento> plantratamientoListNew = datosconsulta.getPlantratamientoList();
            List<DatosconsultaHasDiente> datosconsultaHasDienteListOld = persistentDatosconsulta.getDatosconsultaHasDienteList();
            List<DatosconsultaHasDiente> datosconsultaHasDienteListNew = datosconsulta.getDatosconsultaHasDienteList();
            List<Examenfisicoestomatologico> examenfisicoestomatologicoListOld = persistentDatosconsulta.getExamenfisicoestomatologicoList();
            List<Examenfisicoestomatologico> examenfisicoestomatologicoListNew = datosconsulta.getExamenfisicoestomatologicoList();
            List<Radiografia> radiografiaListOld = persistentDatosconsulta.getRadiografiaList();
            List<Radiografia> radiografiaListNew = datosconsulta.getRadiografiaList();
            List<String> illegalOrphanMessages = null;
            for (DatosconsultaHasDiente datosconsultaHasDienteListOldDatosconsultaHasDiente : datosconsultaHasDienteListOld) {
                if (!datosconsultaHasDienteListNew.contains(datosconsultaHasDienteListOldDatosconsultaHasDiente)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain DatosconsultaHasDiente " + datosconsultaHasDienteListOldDatosconsultaHasDiente + " since its datosconsulta field is not nullable.");
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
            if (medicoIdmedicoNew != null) {
                medicoIdmedicoNew = em.getReference(medicoIdmedicoNew.getClass(), medicoIdmedicoNew.getIdmedico());
                datosconsulta.setMedicoIdmedico(medicoIdmedicoNew);
            }
            if (pacienteIdpersonaNew != null) {
                pacienteIdpersonaNew = em.getReference(pacienteIdpersonaNew.getClass(), pacienteIdpersonaNew.getIdpersona());
                datosconsulta.setPacienteIdpersona(pacienteIdpersonaNew);
            }
            List<Tratamiento> attachedTratamientoListNew = new ArrayList<Tratamiento>();
            for (Tratamiento tratamientoListNewTratamientoToAttach : tratamientoListNew) {
                tratamientoListNewTratamientoToAttach = em.getReference(tratamientoListNewTratamientoToAttach.getClass(), tratamientoListNewTratamientoToAttach.getIdtratamiento());
                attachedTratamientoListNew.add(tratamientoListNewTratamientoToAttach);
            }
            tratamientoListNew = attachedTratamientoListNew;
            datosconsulta.setTratamientoList(tratamientoListNew);
            List<Diagnostico> attachedDiagnosticoListNew = new ArrayList<Diagnostico>();
            for (Diagnostico diagnosticoListNewDiagnosticoToAttach : diagnosticoListNew) {
                diagnosticoListNewDiagnosticoToAttach = em.getReference(diagnosticoListNewDiagnosticoToAttach.getClass(), diagnosticoListNewDiagnosticoToAttach.getIddiagnostico());
                attachedDiagnosticoListNew.add(diagnosticoListNewDiagnosticoToAttach);
            }
            diagnosticoListNew = attachedDiagnosticoListNew;
            datosconsulta.setDiagnosticoList(diagnosticoListNew);
            List<Plantratamiento> attachedPlantratamientoListNew = new ArrayList<Plantratamiento>();
            for (Plantratamiento plantratamientoListNewPlantratamientoToAttach : plantratamientoListNew) {
                plantratamientoListNewPlantratamientoToAttach = em.getReference(plantratamientoListNewPlantratamientoToAttach.getClass(), plantratamientoListNewPlantratamientoToAttach.getIdplanTratamiento());
                attachedPlantratamientoListNew.add(plantratamientoListNewPlantratamientoToAttach);
            }
            plantratamientoListNew = attachedPlantratamientoListNew;
            datosconsulta.setPlantratamientoList(plantratamientoListNew);
            List<DatosconsultaHasDiente> attachedDatosconsultaHasDienteListNew = new ArrayList<DatosconsultaHasDiente>();
            for (DatosconsultaHasDiente datosconsultaHasDienteListNewDatosconsultaHasDienteToAttach : datosconsultaHasDienteListNew) {
                datosconsultaHasDienteListNewDatosconsultaHasDienteToAttach = em.getReference(datosconsultaHasDienteListNewDatosconsultaHasDienteToAttach.getClass(), datosconsultaHasDienteListNewDatosconsultaHasDienteToAttach.getDatosconsultaHasDientePK());
                attachedDatosconsultaHasDienteListNew.add(datosconsultaHasDienteListNewDatosconsultaHasDienteToAttach);
            }
            datosconsultaHasDienteListNew = attachedDatosconsultaHasDienteListNew;
            datosconsulta.setDatosconsultaHasDienteList(datosconsultaHasDienteListNew);
            List<Examenfisicoestomatologico> attachedExamenfisicoestomatologicoListNew = new ArrayList<Examenfisicoestomatologico>();
            for (Examenfisicoestomatologico examenfisicoestomatologicoListNewExamenfisicoestomatologicoToAttach : examenfisicoestomatologicoListNew) {
                examenfisicoestomatologicoListNewExamenfisicoestomatologicoToAttach = em.getReference(examenfisicoestomatologicoListNewExamenfisicoestomatologicoToAttach.getClass(), examenfisicoestomatologicoListNewExamenfisicoestomatologicoToAttach.getIdexamenFisicoEstomatologico());
                attachedExamenfisicoestomatologicoListNew.add(examenfisicoestomatologicoListNewExamenfisicoestomatologicoToAttach);
            }
            examenfisicoestomatologicoListNew = attachedExamenfisicoestomatologicoListNew;
            datosconsulta.setExamenfisicoestomatologicoList(examenfisicoestomatologicoListNew);
            List<Radiografia> attachedRadiografiaListNew = new ArrayList<Radiografia>();
            for (Radiografia radiografiaListNewRadiografiaToAttach : radiografiaListNew) {
                radiografiaListNewRadiografiaToAttach = em.getReference(radiografiaListNewRadiografiaToAttach.getClass(), radiografiaListNewRadiografiaToAttach.getIdradiografia());
                attachedRadiografiaListNew.add(radiografiaListNewRadiografiaToAttach);
            }
            radiografiaListNew = attachedRadiografiaListNew;
            datosconsulta.setRadiografiaList(radiografiaListNew);
            datosconsulta = em.merge(datosconsulta);
            if (medicoIdmedicoOld != null && !medicoIdmedicoOld.equals(medicoIdmedicoNew)) {
                medicoIdmedicoOld.getDatosconsultaList().remove(datosconsulta);
                medicoIdmedicoOld = em.merge(medicoIdmedicoOld);
            }
            if (medicoIdmedicoNew != null && !medicoIdmedicoNew.equals(medicoIdmedicoOld)) {
                medicoIdmedicoNew.getDatosconsultaList().add(datosconsulta);
                medicoIdmedicoNew = em.merge(medicoIdmedicoNew);
            }
            if (pacienteIdpersonaOld != null && !pacienteIdpersonaOld.equals(pacienteIdpersonaNew)) {
                pacienteIdpersonaOld.getDatosconsultaList().remove(datosconsulta);
                pacienteIdpersonaOld = em.merge(pacienteIdpersonaOld);
            }
            if (pacienteIdpersonaNew != null && !pacienteIdpersonaNew.equals(pacienteIdpersonaOld)) {
                pacienteIdpersonaNew.getDatosconsultaList().add(datosconsulta);
                pacienteIdpersonaNew = em.merge(pacienteIdpersonaNew);
            }
            for (Tratamiento tratamientoListOldTratamiento : tratamientoListOld) {
                if (!tratamientoListNew.contains(tratamientoListOldTratamiento)) {
                    tratamientoListOldTratamiento.getDatosconsultaList().remove(datosconsulta);
                    tratamientoListOldTratamiento = em.merge(tratamientoListOldTratamiento);
                }
            }
            for (Tratamiento tratamientoListNewTratamiento : tratamientoListNew) {
                if (!tratamientoListOld.contains(tratamientoListNewTratamiento)) {
                    tratamientoListNewTratamiento.getDatosconsultaList().add(datosconsulta);
                    tratamientoListNewTratamiento = em.merge(tratamientoListNewTratamiento);
                }
            }
            for (Diagnostico diagnosticoListOldDiagnostico : diagnosticoListOld) {
                if (!diagnosticoListNew.contains(diagnosticoListOldDiagnostico)) {
                    diagnosticoListOldDiagnostico.getDatosconsultaList().remove(datosconsulta);
                    diagnosticoListOldDiagnostico = em.merge(diagnosticoListOldDiagnostico);
                }
            }
            for (Diagnostico diagnosticoListNewDiagnostico : diagnosticoListNew) {
                if (!diagnosticoListOld.contains(diagnosticoListNewDiagnostico)) {
                    diagnosticoListNewDiagnostico.getDatosconsultaList().add(datosconsulta);
                    diagnosticoListNewDiagnostico = em.merge(diagnosticoListNewDiagnostico);
                }
            }
            for (Plantratamiento plantratamientoListOldPlantratamiento : plantratamientoListOld) {
                if (!plantratamientoListNew.contains(plantratamientoListOldPlantratamiento)) {
                    plantratamientoListOldPlantratamiento.getDatosconsultaList().remove(datosconsulta);
                    plantratamientoListOldPlantratamiento = em.merge(plantratamientoListOldPlantratamiento);
                }
            }
            for (Plantratamiento plantratamientoListNewPlantratamiento : plantratamientoListNew) {
                if (!plantratamientoListOld.contains(plantratamientoListNewPlantratamiento)) {
                    plantratamientoListNewPlantratamiento.getDatosconsultaList().add(datosconsulta);
                    plantratamientoListNewPlantratamiento = em.merge(plantratamientoListNewPlantratamiento);
                }
            }
            for (DatosconsultaHasDiente datosconsultaHasDienteListNewDatosconsultaHasDiente : datosconsultaHasDienteListNew) {
                if (!datosconsultaHasDienteListOld.contains(datosconsultaHasDienteListNewDatosconsultaHasDiente)) {
                    Datosconsulta oldDatosconsultaOfDatosconsultaHasDienteListNewDatosconsultaHasDiente = datosconsultaHasDienteListNewDatosconsultaHasDiente.getDatosconsulta();
                    datosconsultaHasDienteListNewDatosconsultaHasDiente.setDatosconsulta(datosconsulta);
                    datosconsultaHasDienteListNewDatosconsultaHasDiente = em.merge(datosconsultaHasDienteListNewDatosconsultaHasDiente);
                    if (oldDatosconsultaOfDatosconsultaHasDienteListNewDatosconsultaHasDiente != null && !oldDatosconsultaOfDatosconsultaHasDienteListNewDatosconsultaHasDiente.equals(datosconsulta)) {
                        oldDatosconsultaOfDatosconsultaHasDienteListNewDatosconsultaHasDiente.getDatosconsultaHasDienteList().remove(datosconsultaHasDienteListNewDatosconsultaHasDiente);
                        oldDatosconsultaOfDatosconsultaHasDienteListNewDatosconsultaHasDiente = em.merge(oldDatosconsultaOfDatosconsultaHasDienteListNewDatosconsultaHasDiente);
                    }
                }
            }
            for (Examenfisicoestomatologico examenfisicoestomatologicoListNewExamenfisicoestomatologico : examenfisicoestomatologicoListNew) {
                if (!examenfisicoestomatologicoListOld.contains(examenfisicoestomatologicoListNewExamenfisicoestomatologico)) {
                    Datosconsulta oldDatosConsultaiddatosConsultaOfExamenfisicoestomatologicoListNewExamenfisicoestomatologico = examenfisicoestomatologicoListNewExamenfisicoestomatologico.getDatosConsultaiddatosConsulta();
                    examenfisicoestomatologicoListNewExamenfisicoestomatologico.setDatosConsultaiddatosConsulta(datosconsulta);
                    examenfisicoestomatologicoListNewExamenfisicoestomatologico = em.merge(examenfisicoestomatologicoListNewExamenfisicoestomatologico);
                    if (oldDatosConsultaiddatosConsultaOfExamenfisicoestomatologicoListNewExamenfisicoestomatologico != null && !oldDatosConsultaiddatosConsultaOfExamenfisicoestomatologicoListNewExamenfisicoestomatologico.equals(datosconsulta)) {
                        oldDatosConsultaiddatosConsultaOfExamenfisicoestomatologicoListNewExamenfisicoestomatologico.getExamenfisicoestomatologicoList().remove(examenfisicoestomatologicoListNewExamenfisicoestomatologico);
                        oldDatosConsultaiddatosConsultaOfExamenfisicoestomatologicoListNewExamenfisicoestomatologico = em.merge(oldDatosConsultaiddatosConsultaOfExamenfisicoestomatologicoListNewExamenfisicoestomatologico);
                    }
                }
            }
            for (Radiografia radiografiaListNewRadiografia : radiografiaListNew) {
                if (!radiografiaListOld.contains(radiografiaListNewRadiografia)) {
                    Datosconsulta oldDatosConsultaiddatosConsultaOfRadiografiaListNewRadiografia = radiografiaListNewRadiografia.getDatosConsultaiddatosConsulta();
                    radiografiaListNewRadiografia.setDatosConsultaiddatosConsulta(datosconsulta);
                    radiografiaListNewRadiografia = em.merge(radiografiaListNewRadiografia);
                    if (oldDatosConsultaiddatosConsultaOfRadiografiaListNewRadiografia != null && !oldDatosConsultaiddatosConsultaOfRadiografiaListNewRadiografia.equals(datosconsulta)) {
                        oldDatosConsultaiddatosConsultaOfRadiografiaListNewRadiografia.getRadiografiaList().remove(radiografiaListNewRadiografia);
                        oldDatosConsultaiddatosConsultaOfRadiografiaListNewRadiografia = em.merge(oldDatosConsultaiddatosConsultaOfRadiografiaListNewRadiografia);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = datosconsulta.getIddatosConsulta();
                if (findDatosconsulta(id) == null) {
                    throw new NonexistentEntityException("The datosconsulta with id " + id + " no longer exists.");
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
            Datosconsulta datosconsulta;
            try {
                datosconsulta = em.getReference(Datosconsulta.class, id);
                datosconsulta.getIddatosConsulta();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The datosconsulta with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<DatosconsultaHasDiente> datosconsultaHasDienteListOrphanCheck = datosconsulta.getDatosconsultaHasDienteList();
            for (DatosconsultaHasDiente datosconsultaHasDienteListOrphanCheckDatosconsultaHasDiente : datosconsultaHasDienteListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Datosconsulta (" + datosconsulta + ") cannot be destroyed since the DatosconsultaHasDiente " + datosconsultaHasDienteListOrphanCheckDatosconsultaHasDiente + " in its datosconsultaHasDienteList field has a non-nullable datosconsulta field.");
            }
            List<Examenfisicoestomatologico> examenfisicoestomatologicoListOrphanCheck = datosconsulta.getExamenfisicoestomatologicoList();
            for (Examenfisicoestomatologico examenfisicoestomatologicoListOrphanCheckExamenfisicoestomatologico : examenfisicoestomatologicoListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Datosconsulta (" + datosconsulta + ") cannot be destroyed since the Examenfisicoestomatologico " + examenfisicoestomatologicoListOrphanCheckExamenfisicoestomatologico + " in its examenfisicoestomatologicoList field has a non-nullable datosConsultaiddatosConsulta field.");
            }
            List<Radiografia> radiografiaListOrphanCheck = datosconsulta.getRadiografiaList();
            for (Radiografia radiografiaListOrphanCheckRadiografia : radiografiaListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Datosconsulta (" + datosconsulta + ") cannot be destroyed since the Radiografia " + radiografiaListOrphanCheckRadiografia + " in its radiografiaList field has a non-nullable datosConsultaiddatosConsulta field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            Medico medicoIdmedico = datosconsulta.getMedicoIdmedico();
            if (medicoIdmedico != null) {
                medicoIdmedico.getDatosconsultaList().remove(datosconsulta);
                medicoIdmedico = em.merge(medicoIdmedico);
            }
            Paciente pacienteIdpersona = datosconsulta.getPacienteIdpersona();
            if (pacienteIdpersona != null) {
                pacienteIdpersona.getDatosconsultaList().remove(datosconsulta);
                pacienteIdpersona = em.merge(pacienteIdpersona);
            }
            List<Tratamiento> tratamientoList = datosconsulta.getTratamientoList();
            for (Tratamiento tratamientoListTratamiento : tratamientoList) {
                tratamientoListTratamiento.getDatosconsultaList().remove(datosconsulta);
                tratamientoListTratamiento = em.merge(tratamientoListTratamiento);
            }
            List<Diagnostico> diagnosticoList = datosconsulta.getDiagnosticoList();
            for (Diagnostico diagnosticoListDiagnostico : diagnosticoList) {
                diagnosticoListDiagnostico.getDatosconsultaList().remove(datosconsulta);
                diagnosticoListDiagnostico = em.merge(diagnosticoListDiagnostico);
            }
            List<Plantratamiento> plantratamientoList = datosconsulta.getPlantratamientoList();
            for (Plantratamiento plantratamientoListPlantratamiento : plantratamientoList) {
                plantratamientoListPlantratamiento.getDatosconsultaList().remove(datosconsulta);
                plantratamientoListPlantratamiento = em.merge(plantratamientoListPlantratamiento);
            }
            em.remove(datosconsulta);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Datosconsulta> findDatosconsultaEntities() {
        return findDatosconsultaEntities(true, -1, -1);
    }

    public List<Datosconsulta> findDatosconsultaEntities(int maxResults, int firstResult) {
        return findDatosconsultaEntities(false, maxResults, firstResult);
    }

    private List<Datosconsulta> findDatosconsultaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Datosconsulta.class));
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

    public Datosconsulta findDatosconsulta(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Datosconsulta.class, id);
        } finally {
            em.close();
        }
    }

    public int getDatosconsultaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Datosconsulta> rt = cq.from(Datosconsulta.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
