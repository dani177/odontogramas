/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Oscar Ballesteros
 */
@Entity
@Table(name = "diagnostico")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Diagnostico.findAll", query = "SELECT d FROM Diagnostico d"),
    @NamedQuery(name = "Diagnostico.findByIddiagnostico", query = "SELECT d FROM Diagnostico d WHERE d.iddiagnostico = :iddiagnostico"),
    @NamedQuery(name = "Diagnostico.findByCodigo", query = "SELECT d FROM Diagnostico d WHERE d.codigo = :codigo"),
    @NamedQuery(name = "Diagnostico.findByDiagnostico", query = "SELECT d FROM Diagnostico d WHERE d.diagnostico = :diagnostico")})
public class Diagnostico implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "iddiagnostico")
    private Integer iddiagnostico;
    @Column(name = "codigo")
    private String codigo;
    @Column(name = "diagnostico")
    private String diagnostico;
    @ManyToMany(mappedBy = "diagnosticoList")
    private List<Consulta> consultaList;

    public Diagnostico() {
    }

    public Diagnostico(Integer iddiagnostico) {
        this.iddiagnostico = iddiagnostico;
    }

    public Integer getIddiagnostico() {
        return iddiagnostico;
    }

    public void setIddiagnostico(Integer iddiagnostico) {
        this.iddiagnostico = iddiagnostico;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getDiagnostico() {
        return diagnostico;
    }

    public void setDiagnostico(String diagnostico) {
        this.diagnostico = diagnostico;
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
        hash += (iddiagnostico != null ? iddiagnostico.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Diagnostico)) {
            return false;
        }
        Diagnostico other = (Diagnostico) object;
        if ((this.iddiagnostico == null && other.iddiagnostico != null) || (this.iddiagnostico != null && !this.iddiagnostico.equals(other.iddiagnostico))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.Diagnostico[ iddiagnostico=" + iddiagnostico + " ]";
    }
    
}
