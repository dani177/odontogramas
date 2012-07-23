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
import entity.Departamentos;
import entity.Municipios;
import entity.Paciente;
import entity.controller.exceptions.IllegalOrphanException;
import entity.controller.exceptions.NonexistentEntityException;
import entity.controller.exceptions.PreexistingEntityException;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;


public class MunicipiosJpaController implements Serializable {

     public MunicipiosJpaController() {
    }

    public EntityManager getEntityManager() {
        return jpaConnection.getEntityManager();
    }

    public void create(Municipios municipios) throws PreexistingEntityException, Exception {
        if (municipios.getPacienteList() == null) {
            municipios.setPacienteList(new ArrayList<Paciente>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Departamentos departamentosCodigo1 = municipios.getDepartamentosCodigo1();
            if (departamentosCodigo1 != null) {
                departamentosCodigo1 = em.getReference(departamentosCodigo1.getClass(), departamentosCodigo1.getCodigo());
                municipios.setDepartamentosCodigo1(departamentosCodigo1);
            }
            List<Paciente> attachedPacienteList = new ArrayList<Paciente>();
            for (Paciente pacienteListPacienteToAttach : municipios.getPacienteList()) {
                pacienteListPacienteToAttach = em.getReference(pacienteListPacienteToAttach.getClass(), pacienteListPacienteToAttach.getIdpersona());
                attachedPacienteList.add(pacienteListPacienteToAttach);
            }
            municipios.setPacienteList(attachedPacienteList);
            em.persist(municipios);
            if (departamentosCodigo1 != null) {
                departamentosCodigo1.getMunicipiosList().add(municipios);
                departamentosCodigo1 = em.merge(departamentosCodigo1);
            }
            for (Paciente pacienteListPaciente : municipios.getPacienteList()) {
                Municipios oldMunicipiosCodigoOfPacienteListPaciente = pacienteListPaciente.getMunicipiosCodigo();
                pacienteListPaciente.setMunicipiosCodigo(municipios);
                pacienteListPaciente = em.merge(pacienteListPaciente);
                if (oldMunicipiosCodigoOfPacienteListPaciente != null) {
                    oldMunicipiosCodigoOfPacienteListPaciente.getPacienteList().remove(pacienteListPaciente);
                    oldMunicipiosCodigoOfPacienteListPaciente = em.merge(oldMunicipiosCodigoOfPacienteListPaciente);
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (findMunicipios(municipios.getCodigo()) != null) {
                throw new PreexistingEntityException("Municipios " + municipios + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Municipios municipios) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Municipios persistentMunicipios = em.find(Municipios.class, municipios.getCodigo());
            Departamentos departamentosCodigo1Old = persistentMunicipios.getDepartamentosCodigo1();
            Departamentos departamentosCodigo1New = municipios.getDepartamentosCodigo1();
            List<Paciente> pacienteListOld = persistentMunicipios.getPacienteList();
            List<Paciente> pacienteListNew = municipios.getPacienteList();
            List<String> illegalOrphanMessages = null;
            for (Paciente pacienteListOldPaciente : pacienteListOld) {
                if (!pacienteListNew.contains(pacienteListOldPaciente)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Paciente " + pacienteListOldPaciente + " since its municipiosCodigo field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            if (departamentosCodigo1New != null) {
                departamentosCodigo1New = em.getReference(departamentosCodigo1New.getClass(), departamentosCodigo1New.getCodigo());
                municipios.setDepartamentosCodigo1(departamentosCodigo1New);
            }
            List<Paciente> attachedPacienteListNew = new ArrayList<Paciente>();
            for (Paciente pacienteListNewPacienteToAttach : pacienteListNew) {
                pacienteListNewPacienteToAttach = em.getReference(pacienteListNewPacienteToAttach.getClass(), pacienteListNewPacienteToAttach.getIdpersona());
                attachedPacienteListNew.add(pacienteListNewPacienteToAttach);
            }
            pacienteListNew = attachedPacienteListNew;
            municipios.setPacienteList(pacienteListNew);
            municipios = em.merge(municipios);
            if (departamentosCodigo1Old != null && !departamentosCodigo1Old.equals(departamentosCodigo1New)) {
                departamentosCodigo1Old.getMunicipiosList().remove(municipios);
                departamentosCodigo1Old = em.merge(departamentosCodigo1Old);
            }
            if (departamentosCodigo1New != null && !departamentosCodigo1New.equals(departamentosCodigo1Old)) {
                departamentosCodigo1New.getMunicipiosList().add(municipios);
                departamentosCodigo1New = em.merge(departamentosCodigo1New);
            }
            for (Paciente pacienteListNewPaciente : pacienteListNew) {
                if (!pacienteListOld.contains(pacienteListNewPaciente)) {
                    Municipios oldMunicipiosCodigoOfPacienteListNewPaciente = pacienteListNewPaciente.getMunicipiosCodigo();
                    pacienteListNewPaciente.setMunicipiosCodigo(municipios);
                    pacienteListNewPaciente = em.merge(pacienteListNewPaciente);
                    if (oldMunicipiosCodigoOfPacienteListNewPaciente != null && !oldMunicipiosCodigoOfPacienteListNewPaciente.equals(municipios)) {
                        oldMunicipiosCodigoOfPacienteListNewPaciente.getPacienteList().remove(pacienteListNewPaciente);
                        oldMunicipiosCodigoOfPacienteListNewPaciente = em.merge(oldMunicipiosCodigoOfPacienteListNewPaciente);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = municipios.getCodigo();
                if (findMunicipios(id) == null) {
                    throw new NonexistentEntityException("The municipios with id " + id + " no longer exists.");
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
            Municipios municipios;
            try {
                municipios = em.getReference(Municipios.class, id);
                municipios.getCodigo();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The municipios with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<Paciente> pacienteListOrphanCheck = municipios.getPacienteList();
            for (Paciente pacienteListOrphanCheckPaciente : pacienteListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Municipios (" + municipios + ") cannot be destroyed since the Paciente " + pacienteListOrphanCheckPaciente + " in its pacienteList field has a non-nullable municipiosCodigo field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            Departamentos departamentosCodigo1 = municipios.getDepartamentosCodigo1();
            if (departamentosCodigo1 != null) {
                departamentosCodigo1.getMunicipiosList().remove(municipios);
                departamentosCodigo1 = em.merge(departamentosCodigo1);
            }
            em.remove(municipios);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Municipios> findMunicipiosEntities() {
        return findMunicipiosEntities(true, -1, -1);
    }

    public List<Municipios> findMunicipiosEntities(int maxResults, int firstResult) {
        return findMunicipiosEntities(false, maxResults, firstResult);
    }

    private List<Municipios> findMunicipiosEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Municipios.class));
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

    public Municipios findMunicipios(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Municipios.class, id);
        } finally {
            em.close();
        }
    }

    public int getMunicipiosCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Municipios> rt = cq.from(Municipios.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
