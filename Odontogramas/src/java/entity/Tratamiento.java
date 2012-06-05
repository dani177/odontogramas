/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package entity;

import java.io.Serializable;
import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;


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
    @JoinColumn(name = "diagnostico_iddiagnostico", referencedColumnName = "iddiagnostico")
    @ManyToOne(optional = false)
    private Diagnostico diagnosticoIddiagnostico;

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

    public Diagnostico getDiagnosticoIddiagnostico() {
        return diagnosticoIddiagnostico;
    }

    public void setDiagnosticoIddiagnostico(Diagnostico diagnosticoIddiagnostico) {
        this.diagnosticoIddiagnostico = diagnosticoIddiagnostico;
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
