/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package entity.controller;

import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import entity.Paciente;
import entity.Plantratamiento;
import entity.controller.exceptions.NonexistentEntityException;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;


public class PlantratamientoJpaController implements Serializable {

    public PlantratamientoJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Plantratamiento plantratamiento) {
        if (plantratamiento.getPacienteList() == null) {
            plantratamiento.setPacienteList(new ArrayList<Paciente>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<Paciente> attachedPacienteList = new ArrayList<Paciente>();
            for (Paciente pacienteListPacienteToAttach : plantratamiento.getPacienteList()) {
                pacienteListPacienteToAttach = em.getReference(pacienteListPacienteToAttach.getClass(), pacienteListPacienteToAttach.getIdpersona());
                attachedPacienteList.add(pacienteListPacienteToAttach);
            }
            plantratamiento.setPacienteList(attachedPacienteList);
            em.persist(plantratamiento);
            for (Paciente pacienteListPaciente : plantratamiento.getPacienteList()) {
                pacienteListPaciente.getPlantratamientoList().add(plantratamiento);
                pacienteListPaciente = em.merge(pacienteListPaciente);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Plantratamiento plantratamiento) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Plantratamiento persistentPlantratamiento = em.find(Plantratamiento.class, plantratamiento.getIdplanTratamiento());
            List<Paciente> pacienteListOld = persistentPlantratamiento.getPacienteList();
            List<Paciente> pacienteListNew = plantratamiento.getPacienteList();
            List<Paciente> attachedPacienteListNew = new ArrayList<Paciente>();
            for (Paciente pacienteListNewPacienteToAttach : pacienteListNew) {
                pacienteListNewPacienteToAttach = em.getReference(pacienteListNewPacienteToAttach.getClass(), pacienteListNewPacienteToAttach.getIdpersona());
                attachedPacienteListNew.add(pacienteListNewPacienteToAttach);
            }
            pacienteListNew = attachedPacienteListNew;
            plantratamiento.setPacienteList(pacienteListNew);
            plantratamiento = em.merge(plantratamiento);
            for (Paciente pacienteListOldPaciente : pacienteListOld) {
                if (!pacienteListNew.contains(pacienteListOldPaciente)) {
                    pacienteListOldPaciente.getPlantratamientoList().remove(plantratamiento);
                    pacienteListOldPaciente = em.merge(pacienteListOldPaciente);
                }
            }
            for (Paciente pacienteListNewPaciente : pacienteListNew) {
                if (!pacienteListOld.contains(pacienteListNewPaciente)) {
                    pacienteListNewPaciente.getPlantratamientoList().add(plantratamiento);
                    pacienteListNewPaciente = em.merge(pacienteListNewPaciente);
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = plantratamiento.getIdplanTratamiento();
                if (findPlantratamiento(id) == null) {
                    throw new NonexistentEntityException("The plantratamiento with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Integer id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Plantratamiento plantratamiento;
            try {
                plantratamiento = em.getReference(Plantratamiento.class, id);
                plantratamiento.getIdplanTratamiento();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The plantratamiento with id " + id + " no longer exists.", enfe);
            }
            List<Paciente> pacienteList = plantratamiento.getPacienteList();
            for (Paciente pacienteListPaciente : pacienteList) {
                pacienteListPaciente.getPlantratamientoList().remove(plantratamiento);
                pacienteListPaciente = em.merge(pacienteListPaciente);
            }
            em.remove(plantratamiento);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Plantratamiento> findPlantratamientoEntities() {
        return findPlantratamientoEntities(true, -1, -1);
    }

    public List<Plantratamiento> findPlantratamientoEntities(int maxResults, int firstResult) {
        return findPlantratamientoEntities(false, maxResults, firstResult);
    }

    private List<Plantratamiento> findPlantratamientoEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Plantratamiento.class));
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

    public Plantratamiento findPlantratamiento(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Plantratamiento.class, id);
        } finally {
            em.close();
        }
    }

    public int getPlantratamientoCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Plantratamiento> rt = cq.from(Plantratamiento.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

}
