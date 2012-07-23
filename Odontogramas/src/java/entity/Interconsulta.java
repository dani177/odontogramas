/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package entity;

import java.io.Serializable;
import java.util.List;
import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;


@Entity
@Table(name = "interconsulta")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Interconsulta.findAll", query = "SELECT i FROM Interconsulta i"),
    @NamedQuery(name = "Interconsulta.findByIdinterconsulta", query = "SELECT i FROM Interconsulta i WHERE i.idinterconsulta = :idinterconsulta"),
    @NamedQuery(name = "Interconsulta.findByInterconsulta", query = "SELECT i FROM Interconsulta i WHERE i.interconsulta = :interconsulta")})
public class Interconsulta implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "idinterconsulta")
    private Integer idinterconsulta;
    @Column(name = "interconsulta")
    private String interconsulta;
    @JoinTable(name = "interconsulta_has_datosconsulta", joinColumns = {
        @JoinColumn(name = "interconsulta_idinterconsulta", referencedColumnName = "idinterconsulta")}, inverseJoinColumns = {
        @JoinColumn(name = "datosConsulta_iddatosConsulta", referencedColumnName = "iddatosConsulta")})
    @ManyToMany
    private List<Consulta> consultaList;

    public Interconsulta() {
    }

    public Interconsulta(Integer idinterconsulta) {
        this.idinterconsulta = idinterconsulta;
    }

    public Integer getIdinterconsulta() {
        return idinterconsulta;
    }

    public void setIdinterconsulta(Integer idinterconsulta) {
        this.idinterconsulta = idinterconsulta;
    }

    public String getInterconsulta() {
        return interconsulta;
    }

    public void setInterconsulta(String interconsulta) {
        this.interconsulta = interconsulta;
    }

    @XmlTransient
    public List<Consulta> getConsultaList() {
        return consultaList;
    }

    public void setConsultaList(List<Consulta> consultaList) {
        this.consultaList = consultaList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idinterconsulta != null ? idinterconsulta.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Interconsulta)) {
            return false;
        }
        Interconsulta other = (Interconsulta) object;
        if ((this.idinterconsulta == null && other.idinterconsulta != null) || (this.idinterconsulta != null && !this.idinterconsulta.equals(other.idinterconsulta))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.Interconsulta[ idinterconsulta=" + idinterconsulta + " ]";
    }

}
