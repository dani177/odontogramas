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
@Table(name = "diagnostico")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Diagnostico.findAll", query = "SELECT d FROM Diagnostico d"),
    @NamedQuery(name = "Diagnostico.findByIddiagnostico", query = "SELECT d FROM Diagnostico d WHERE d.iddiagnostico = :iddiagnostico"),
    @NamedQuery(name = "Diagnostico.findByCodigo", query = "SELECT d FROM Diagnostico d WHERE d.codigo = :codigo"),
    @NamedQuery(name = "Diagnostico.findByDiagnostico", query = "SELECT d FROM Diagnostico d WHERE d.diagnostico = :diagnostico"),
    @NamedQuery(name = "Diagnostico.findByPronostico", query = "SELECT d FROM Diagnostico d WHERE d.pronostico = :pronostico")})
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
    @Column(name = "pronostico")
    private String pronostico;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "diagnosticoIddiagnostico")
    private List<Evolucion> evolucionList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "diagnosticoIddiagnostico")
    private List<Tratamiento> tratamientoList;
    @JoinColumn(name = "paciente_idpersona", referencedColumnName = "idpersona")
    @ManyToOne(optional = false)
    private Paciente pacienteIdpersona;

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

    public String getPronostico() {
        return pronostico;
    }

    public void setPronostico(String pronostico) {
        this.pronostico = pronostico;
    }

    @XmlTransient
    public List<Evolucion> getEvolucionList() {
        return evolucionList;
    }

    public void setEvolucionList(List<Evolucion> evolucionList) {
        this.evolucionList = evolucionList;
    }

    @XmlTransient
    public List<Tratamiento> getTratamientoList() {
        return tratamientoList;
    }

    public void setTratamientoList(List<Tratamiento> tratamientoList) {
        this.tratamientoList = tratamientoList;
    }

    public Paciente getPacienteIdpersona() {
        return pacienteIdpersona;
    }

    public void setPacienteIdpersona(Paciente pacienteIdpersona) {
        this.pacienteIdpersona = pacienteIdpersona;
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
