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
import entity.Medico;
import java.util.ArrayList;
import java.util.List;
import entity.Curso;
import entity.Consulta;
import entity.Docente;
import entity.controller.exceptions.IllegalOrphanException;
import entity.controller.exceptions.NonexistentEntityException;
import entity.controller.exceptions.PreexistingEntityException;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

/**
 *
 * @author jubarcos
 */
public class DocenteJpaController implements Serializable {

    public DocenteJpaController() {
    }

    public EntityManager getEntityManager() {
         return jpaConnection.getEntityManager();
    }

    public void create(Docente docente) throws PreexistingEntityException, Exception {
        if (docente.getMedicoList() == null) {
            docente.setMedicoList(new ArrayList<Medico>());
        }
        if (docente.getCursoList() == null) {
            docente.setCursoList(new ArrayList<Curso>());
        }
        if (docente.getConsultaList() == null) {
            docente.setConsultaList(new ArrayList<Consulta>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<Medico> attachedMedicoList = new ArrayList<Medico>();
            for (Medico medicoListMedicoToAttach : docente.getMedicoList()) {
                medicoListMedicoToAttach = em.getReference(medicoListMedicoToAttach.getClass(), medicoListMedicoToAttach.getIdmedico());
                attachedMedicoList.add(medicoListMedicoToAttach);
            }
            docente.setMedicoList(attachedMedicoList);
            List<Curso> attachedCursoList = new ArrayList<Curso>();
            for (Curso cursoListCursoToAttach : docente.getCursoList()) {
                cursoListCursoToAttach = em.getReference(cursoListCursoToAttach.getClass(), cursoListCursoToAttach.getIdcurso());
                attachedCursoList.add(cursoListCursoToAttach);
            }
            docente.setCursoList(attachedCursoList);
            List<Consulta> attachedConsultaList = new ArrayList<Consulta>();
            for (Consulta consultaListConsultaToAttach : docente.getConsultaList()) {
                consultaListConsultaToAttach = em.getReference(consultaListConsultaToAttach.getClass(), consultaListConsultaToAttach.getIddatosConsulta());
                attachedConsultaList.add(consultaListConsultaToAttach);
            }
            docente.setConsultaList(attachedConsultaList);
            em.persist(docente);
            for (Medico medicoListMedico : docente.getMedicoList()) {
                medicoListMedico.getDocenteList().add(docente);
                medicoListMedico = em.merge(medicoListMedico);
            }
            for (Curso cursoListCurso : docente.getCursoList()) {
                cursoListCurso.getDocenteList().add(docente);
                cursoListCurso = em.merge(cursoListCurso);
            }
            for (Consulta consultaListConsulta : docente.getConsultaList()) {
                Docente oldDocenteIddocenteOfConsultaListConsulta = consultaListConsulta.getDocenteIddocente();
                consultaListConsulta.setDocenteIddocente(docente);
                consultaListConsulta = em.merge(consultaListConsulta);
                if (oldDocenteIddocenteOfConsultaListConsulta != null) {
                    oldDocenteIddocenteOfConsultaListConsulta.getConsultaList().remove(consultaListConsulta);
                    oldDocenteIddocenteOfConsultaListConsulta = em.merge(oldDocenteIddocenteOfConsultaListConsulta);
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (findDocente(docente.getIddocente()) != null) {
                throw new PreexistingEntityException("Docente " + docente + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Docente docente) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Docente persistentDocente = em.find(Docente.class, docente.getIddocente());
            List<Medico> medicoListOld = persistentDocente.getMedicoList();
            List<Medico> medicoListNew = docente.getMedicoList();
            List<Curso> cursoListOld = persistentDocente.getCursoList();
            List<Curso> cursoListNew = docente.getCursoList();
            List<Consulta> consultaListOld = persistentDocente.getConsultaList();
            List<Consulta> consultaListNew = docente.getConsultaList();
            List<String> illegalOrphanMessages = null;
            for (Consulta consultaListOldConsulta : consultaListOld) {
                if (!consultaListNew.contains(consultaListOldConsulta)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Consulta " + consultaListOldConsulta + " since its docenteIddocente field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            List<Medico> attachedMedicoListNew = new ArrayList<Medico>();
            for (Medico medicoListNewMedicoToAttach : medicoListNew) {
                medicoListNewMedicoToAttach = em.getReference(medicoListNewMedicoToAttach.getClass(), medicoListNewMedicoToAttach.getIdmedico());
                attachedMedicoListNew.add(medicoListNewMedicoToAttach);
            }
            medicoListNew = attachedMedicoListNew;
            docente.setMedicoList(medicoListNew);
            List<Curso> attachedCursoListNew = new ArrayList<Curso>();
            for (Curso cursoListNewCursoToAttach : cursoListNew) {
                cursoListNewCursoToAttach = em.getReference(cursoListNewCursoToAttach.getClass(), cursoListNewCursoToAttach.getIdcurso());
                attachedCursoListNew.add(cursoListNewCursoToAttach);
            }
            cursoListNew = attachedCursoListNew;
            docente.setCursoList(cursoListNew);
            List<Consulta> attachedConsultaListNew = new ArrayList<Consulta>();
            for (Consulta consultaListNewConsultaToAttach : consultaListNew) {
                consultaListNewConsultaToAttach = em.getReference(consultaListNewConsultaToAttach.getClass(), consultaListNewConsultaToAttach.getIddatosConsulta());
                attachedConsultaListNew.add(consultaListNewConsultaToAttach);
            }
            consultaListNew = attachedConsultaListNew;
            docente.setConsultaList(consultaListNew);
            docente = em.merge(docente);
            for (Medico medicoListOldMedico : medicoListOld) {
                if (!medicoListNew.contains(medicoListOldMedico)) {
                    medicoListOldMedico.getDocenteList().remove(docente);
                    medicoListOldMedico = em.merge(medicoListOldMedico);
                }
            }
            for (Medico medicoListNewMedico : medicoListNew) {
                if (!medicoListOld.contains(medicoListNewMedico)) {
                    medicoListNewMedico.getDocenteList().add(docente);
                    medicoListNewMedico = em.merge(medicoListNewMedico);
                }
            }
            for (Curso cursoListOldCurso : cursoListOld) {
                if (!cursoListNew.contains(cursoListOldCurso)) {
                    cursoListOldCurso.getDocenteList().remove(docente);
                    cursoListOldCurso = em.merge(cursoListOldCurso);
                }
            }
            for (Curso cursoListNewCurso : cursoListNew) {
                if (!cursoListOld.contains(cursoListNewCurso)) {
                    cursoListNewCurso.getDocenteList().add(docente);
                    cursoListNewCurso = em.merge(cursoListNewCurso);
                }
            }
            for (Consulta consultaListNewConsulta : consultaListNew) {
                if (!consultaListOld.contains(consultaListNewConsulta)) {
                    Docente oldDocenteIddocenteOfConsultaListNewConsulta = consultaListNewConsulta.getDocenteIddocente();
                    consultaListNewConsulta.setDocenteIddocente(docente);
                    consultaListNewConsulta = em.merge(consultaListNewConsulta);
                    if (oldDocenteIddocenteOfConsultaListNewConsulta != null && !oldDocenteIddocenteOfConsultaListNewConsulta.equals(docente)) {
                        oldDocenteIddocenteOfConsultaListNewConsulta.getConsultaList().remove(consultaListNewConsulta);
                        oldDocenteIddocenteOfConsultaListNewConsulta = em.merge(oldDocenteIddocenteOfConsultaListNewConsulta);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = docente.getIddocente();
                if (findDocente(id) == null) {
                    throw new NonexistentEntityException("The docente with id " + id + " no longer exists.");
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
            Docente docente;
            try {
                docente = em.getReference(Docente.class, id);
                docente.getIddocente();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The docente with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<Consulta> consultaListOrphanCheck = docente.getConsultaList();
            for (Consulta consultaListOrphanCheckConsulta : consultaListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Docente (" + docente + ") cannot be destroyed since the Consulta " + consultaListOrphanCheckConsulta + " in its consultaList field has a non-nullable docenteIddocente field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            List<Medico> medicoList = docente.getMedicoList();
            for (Medico medicoListMedico : medicoList) {
                medicoListMedico.getDocenteList().remove(docente);
                medicoListMedico = em.merge(medicoListMedico);
            }
            List<Curso> cursoList = docente.getCursoList();
            for (Curso cursoListCurso : cursoList) {
                cursoListCurso.getDocenteList().remove(docente);
                cursoListCurso = em.merge(cursoListCurso);
            }
            em.remove(docente);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Docente> findDocenteEntities() {
        return findDocenteEntities(true, -1, -1);
    }

    public List<Docente> findDocenteEntities(int maxResults, int firstResult) {
        return findDocenteEntities(false, maxResults, firstResult);
    }

    private List<Docente> findDocenteEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Docente.class));
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

    public Docente findDocente(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Docente.class, id);
        } finally {
            em.close();
        }
    }

    public int getDocenteCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Docente> rt = cq.from(Docente.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
