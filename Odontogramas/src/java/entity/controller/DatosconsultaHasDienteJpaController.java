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
import entity.Diente;
import entity.Consulta;
import entity.DatosconsultaHasDiente;
import entity.DatosconsultaHasDientePK;
import entity.controller.exceptions.NonexistentEntityException;
import entity.controller.exceptions.PreexistingEntityException;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;


public class DatosconsultaHasDienteJpaController implements Serializable {

    public DatosconsultaHasDienteJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(DatosconsultaHasDiente datosconsultaHasDiente) throws PreexistingEntityException, Exception {
        if (datosconsultaHasDiente.getDatosconsultaHasDientePK() == null) {
            datosconsultaHasDiente.setDatosconsultaHasDientePK(new DatosconsultaHasDientePK());
        }
        datosconsultaHasDiente.getDatosconsultaHasDientePK().setDatosConsultaiddatosConsulta(datosconsultaHasDiente.getConsulta().getIddatosConsulta());
        datosconsultaHasDiente.getDatosconsultaHasDientePK().setDienteIddiente(datosconsultaHasDiente.getDiente().getIddiente());
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Diente diente = datosconsultaHasDiente.getDiente();
            if (diente != null) {
                diente = em.getReference(diente.getClass(), diente.getIddiente());
                datosconsultaHasDiente.setDiente(diente);
            }
            Consulta consulta = datosconsultaHasDiente.getConsulta();
            if (consulta != null) {
                consulta = em.getReference(consulta.getClass(), consulta.getIddatosConsulta());
                datosconsultaHasDiente.setConsulta(consulta);
            }
            em.persist(datosconsultaHasDiente);
            if (diente != null) {
                diente.getDatosconsultaHasDienteList().add(datosconsultaHasDiente);
                diente = em.merge(diente);
            }
            if (consulta != null) {
                consulta.getDatosconsultaHasDienteList().add(datosconsultaHasDiente);
                consulta = em.merge(consulta);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (findDatosconsultaHasDiente(datosconsultaHasDiente.getDatosconsultaHasDientePK()) != null) {
                throw new PreexistingEntityException("DatosconsultaHasDiente " + datosconsultaHasDiente + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(DatosconsultaHasDiente datosconsultaHasDiente) throws NonexistentEntityException, Exception {
        datosconsultaHasDiente.getDatosconsultaHasDientePK().setDatosConsultaiddatosConsulta(datosconsultaHasDiente.getConsulta().getIddatosConsulta());
        datosconsultaHasDiente.getDatosconsultaHasDientePK().setDienteIddiente(datosconsultaHasDiente.getDiente().getIddiente());
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            DatosconsultaHasDiente persistentDatosconsultaHasDiente = em.find(DatosconsultaHasDiente.class, datosconsultaHasDiente.getDatosconsultaHasDientePK());
            Diente dienteOld = persistentDatosconsultaHasDiente.getDiente();
            Diente dienteNew = datosconsultaHasDiente.getDiente();
            Consulta consultaOld = persistentDatosconsultaHasDiente.getConsulta();
            Consulta consultaNew = datosconsultaHasDiente.getConsulta();
            if (dienteNew != null) {
                dienteNew = em.getReference(dienteNew.getClass(), dienteNew.getIddiente());
                datosconsultaHasDiente.setDiente(dienteNew);
            }
            if (consultaNew != null) {
                consultaNew = em.getReference(consultaNew.getClass(), consultaNew.getIddatosConsulta());
                datosconsultaHasDiente.setConsulta(consultaNew);
            }
            datosconsultaHasDiente = em.merge(datosconsultaHasDiente);
            if (dienteOld != null && !dienteOld.equals(dienteNew)) {
                dienteOld.getDatosconsultaHasDienteList().remove(datosconsultaHasDiente);
                dienteOld = em.merge(dienteOld);
            }
            if (dienteNew != null && !dienteNew.equals(dienteOld)) {
                dienteNew.getDatosconsultaHasDienteList().add(datosconsultaHasDiente);
                dienteNew = em.merge(dienteNew);
            }
            if (consultaOld != null && !consultaOld.equals(consultaNew)) {
                consultaOld.getDatosconsultaHasDienteList().remove(datosconsultaHasDiente);
                consultaOld = em.merge(consultaOld);
            }
            if (consultaNew != null && !consultaNew.equals(consultaOld)) {
                consultaNew.getDatosconsultaHasDienteList().add(datosconsultaHasDiente);
                consultaNew = em.merge(consultaNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                DatosconsultaHasDientePK id = datosconsultaHasDiente.getDatosconsultaHasDientePK();
                if (findDatosconsultaHasDiente(id) == null) {
                    throw new NonexistentEntityException("The datosconsultaHasDiente with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(DatosconsultaHasDientePK id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            DatosconsultaHasDiente datosconsultaHasDiente;
            try {
                datosconsultaHasDiente = em.getReference(DatosconsultaHasDiente.class, id);
                datosconsultaHasDiente.getDatosconsultaHasDientePK();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The datosconsultaHasDiente with id " + id + " no longer exists.", enfe);
            }
            Diente diente = datosconsultaHasDiente.getDiente();
            if (diente != null) {
                diente.getDatosconsultaHasDienteList().remove(datosconsultaHasDiente);
                diente = em.merge(diente);
            }
            Consulta consulta = datosconsultaHasDiente.getConsulta();
            if (consulta != null) {
                consulta.getDatosconsultaHasDienteList().remove(datosconsultaHasDiente);
                consulta = em.merge(consulta);
            }
            em.remove(datosconsultaHasDiente);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<DatosconsultaHasDiente> findDatosconsultaHasDienteEntities() {
        return findDatosconsultaHasDienteEntities(true, -1, -1);
    }

    public List<DatosconsultaHasDiente> findDatosconsultaHasDienteEntities(int maxResults, int firstResult) {
        return findDatosconsultaHasDienteEntities(false, maxResults, firstResult);
    }

    private List<DatosconsultaHasDiente> findDatosconsultaHasDienteEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(DatosconsultaHasDiente.class));
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

    public DatosconsultaHasDiente findDatosconsultaHasDiente(DatosconsultaHasDientePK id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(DatosconsultaHasDiente.class, id);
        } finally {
            em.close();
        }
    }

    public int getDatosconsultaHasDienteCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<DatosconsultaHasDiente> rt = cq.from(DatosconsultaHasDiente.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

}
