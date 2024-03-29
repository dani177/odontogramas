/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Oscar Ballesteros
 */
@Entity
@Table(name = "tratamiento")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Tratamiento.findAll", query = "SELECT t FROM Tratamiento t"),
    @NamedQuery(name = "Tratamiento.findByIdtratamiento", query = "SELECT t FROM Tratamiento t WHERE t.idtratamiento = :idtratamiento"),
    @NamedQuery(name = "Tratamiento.findByTratamiento", query = "SELECT t FROM Tratamiento t WHERE t.tratamiento = :tratamiento"),
    @NamedQuery(name = "Tratamiento.findByPresupuesto", query = "SELECT t FROM Tratamiento t WHERE t.presupuesto = :presupuesto")})
public class Tratamiento implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idtratamiento")
    private Integer idtratamiento;
    @Column(name = "tratamiento")
    private String tratamiento;
    @Column(name = "presupuesto")
    private String presupuesto;
    @ManyToMany(mappedBy = "tratamientoList")
    private List<Consulta> consultaList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tratamientoIdtratamiento")
    private List<Evolucion> evolucionList;

    public Tratamiento() {
    }

    public Tratamiento(Integer idtratamiento) {
        this.idtratamiento = idtratamiento;
    }

    public Integer getIdtratamiento() {
        return idtratamiento;
    }

    public void setIdtratamiento(Integer idtratamiento) {
        this.idtratamiento = idtratamiento;
    }

    public String getTratamiento() {
        return tratamiento;
    }

    public void setTratamiento(String tratamiento) {
        this.tratamiento = tratamiento;
    }

    public String getPresupuesto() {
        return presupuesto;
    }

    public void setPresupuesto(String presupuesto) {
        this.presupuesto = presupuesto;
    }

    @XmlTransient
    public List<Consulta> getConsultaList() {
        return consultaList;
    }

    public void setConsultaList(List<Consulta> consultaList) {
        this.consultaList = consultaList;
    }

    @XmlTransient
    public List<Evolucion> getEvolucionList() {
        return evolucionList;
    }

    public void setEvolucionList(List<Evolucion> evolucionList) {
        this.evolucionList = evolucionList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idtratamiento != null ? idtratamiento.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tratamiento)) {
            return false;
        }
        Tratamiento other = (Tratamiento) object;
        if ((this.idtratamiento == null && other.idtratamiento != null) || (this.idtratamiento != null && !this.idtratamiento.equals(other.idtratamiento))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.Tratamiento[ idtratamiento=" + idtratamiento + " ]";
    }
    
}
