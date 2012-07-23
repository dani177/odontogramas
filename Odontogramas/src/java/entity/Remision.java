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
@Table(name = "remision")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Remision.findAll", query = "SELECT r FROM Remision r"),
    @NamedQuery(name = "Remision.findByIdremision", query = "SELECT r FROM Remision r WHERE r.idremision = :idremision"),
    @NamedQuery(name = "Remision.findByRemision", query = "SELECT r FROM Remision r WHERE r.remision = :remision")})
public class Remision implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "idremision")
    private Integer idremision;
    @Column(name = "remision")
    private String remision;
    @JoinTable(name = "remision_has_datosconsulta", joinColumns = {
        @JoinColumn(name = "remision_idremision", referencedColumnName = "idremision")}, inverseJoinColumns = {
        @JoinColumn(name = "datosConsulta_iddatosConsulta", referencedColumnName = "iddatosConsulta")})
    @ManyToMany
    private List<Consulta> consultaList;

    public Remision() {
    }

    public Remision(Integer idremision) {
        this.idremision = idremision;
    }

    public Integer getIdremision() {
        return idremision;
    }

    public void setIdremision(Integer idremision) {
        this.idremision = idremision;
    }

    public String getRemision() {
        return remision;
    }

    public void setRemision(String remision) {
        this.remision = remision;
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
        hash += (idremision != null ? idremision.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Remision)) {
            return false;
        }
        Remision other = (Remision) object;
        if ((this.idremision == null && other.idremision != null) || (this.idremision != null && !this.idremision.equals(other.idremision))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.Remision[ idremision=" + idremision + " ]";
    }

}
