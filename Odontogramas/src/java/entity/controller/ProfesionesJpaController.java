/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package entity.controller;

import conexion.jpaConnection;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import entity.Paciente;
import entity.Profesiones;
import entity.controller.exceptions.IllegalOrphanException;
import entity.controller.exceptions.NonexistentEntityException;
import entity.controller.exceptions.PreexistingEntityException;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;


public class ProfesionesJpaController implements Serializable {

    public ProfesionesJpaController() {
    }

    public EntityManager getEntityManager() {
        return jpaConnection.getEntityManager();
    }

    public void create(Profesiones profesiones) throws PreexistingEntityException, Exception {
        if (profesiones.getPacienteList() == null) {
            profesiones.setPacienteList(new ArrayList<Paciente>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<Paciente> attachedPacienteList = new ArrayList<Paciente>();
            for (Paciente pacienteListPacienteToAttach : profesiones.getPacienteList()) {
                pacienteListPacienteToAttach = em.getReference(pacienteListPacienteToAttach.getClass(), pacienteListPacienteToAttach.getIdpersona());
                attachedPacienteList.add(pacienteListPacienteToAttach);
            }
            profesiones.setPacienteList(attachedPacienteList);
            em.persist(profesiones);
            for (Paciente pacienteListPaciente : profesiones.getPacienteList()) {
                Profesiones oldProfesionesCodigoOfPacienteListPaciente = pacienteListPaciente.getProfesionesCodigo();
                pacienteListPaciente.setProfesionesCodigo(profesiones);
                pacienteListPaciente = em.merge(pacienteListPaciente);
                if (oldProfesionesCodigoOfPacienteListPaciente != null) {
                    oldProfesionesCodigoOfPacienteListPaciente.getPacienteList().remove(pacienteListPaciente);
                    oldProfesionesCodigoOfPacienteListPaciente = em.merge(oldProfesionesCodigoOfPacienteListPaciente);
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (findProfesiones(profesiones.getCodigo()) != null) {
                throw new PreexistingEntityException("Profesiones " + profesiones + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Profesiones profesiones) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Profesiones persistentProfesiones = em.find(Profesiones.class, profesiones.getCodigo());
            List<Paciente> pacienteListOld = persistentProfesiones.getPacienteList();
            List<Paciente> pacienteListNew = profesiones.getPacienteList();
            List<String> illegalOrphanMessages = null;
            for (Paciente pacienteListOldPaciente : pacienteListOld) {
                if (!pacienteListNew.contains(pacienteListOldPaciente)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Paciente " + pacienteListOldPaciente + " since its profesionesCodigo field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            List<Paciente> attachedPacienteListNew = new ArrayList<Paciente>();
            for (Paciente pacienteListNewPacienteToAttach : pacienteListNew) {
                pacienteListNewPacienteToAttach = em.getReference(pacienteListNewPacienteToAttach.getClass(), pacienteListNewPacienteToAttach.getIdpersona());
                attachedPacienteListNew.add(pacienteListNewPacienteToAttach);
            }
            pacienteListNew = attachedPacienteListNew;
            profesiones.setPacienteList(pacienteListNew);
            profesiones = em.merge(profesiones);
            for (Paciente pacienteListNewPaciente : pacienteListNew) {
                if (!pacienteListOld.contains(pacienteListNewPaciente)) {
                    Profesiones oldProfesionesCodigoOfPacienteListNewPaciente = pacienteListNewPaciente.getProfesionesCodigo();
                    pacienteListNewPaciente.setProfesionesCodigo(profesiones);
                    pacienteListNewPaciente = em.merge(pacienteListNewPaciente);
                    if (oldProfesionesCodigoOfPacienteListNewPaciente != null && !oldProfesionesCodigoOfPacienteListNewPaciente.equals(profesiones)) {
                        oldProfesionesCodigoOfPacienteListNewPaciente.getPacienteList().remove(pacienteListNewPaciente);
                        oldProfesionesCodigoOfPacienteListNewPaciente = em.merge(oldProfesionesCodigoOfPacienteListNewPaciente);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = profesiones.getCodigo();
                if (findProfesiones(id) == null) {
                    throw new NonexistentEntityException("The profesiones with id " + id + " no longer exists.");
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
            Profesiones profesiones;
            try {
                profesiones = em.getReference(Profesiones.class, id);
                profesiones.getCodigo();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The profesiones with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<Paciente> pacienteListOrphanCheck = profesiones.getPacienteList();
            for (Paciente pacienteListOrphanCheckPaciente : pacienteListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Profesiones (" + profesiones + ") cannot be destroyed since the Paciente " + pacienteListOrphanCheckPaciente + " in its pacienteList field has a non-nullable profesionesCodigo field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            em.remove(profesiones);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Profesiones> findProfesionesEntities() {
        return findProfesionesEntities(true, -1, -1);
    }

    public List<Profesiones> findProfesionesEntities(int maxResults, int firstResult) {
        return findProfesionesEntities(false, maxResults, firstResult);
    }

    private List<Profesiones> findProfesionesEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Profesiones.class));
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

    public Profesiones findProfesiones(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Profesiones.class, id);
        } finally {
            em.close();
        }
    }

    public int getProfesionesCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Profesiones> rt = cq.from(Profesiones.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
