/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package entity;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;


@Entity
@Table(name = "evolucion")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Evolucion.findAll", query = "SELECT e FROM Evolucion e"),
    @NamedQuery(name = "Evolucion.findByIdevolucion", query = "SELECT e FROM Evolucion e WHERE e.idevolucion = :idevolucion"),
    @NamedQuery(name = "Evolucion.findByFecha", query = "SELECT e FROM Evolucion e WHERE e.fecha = :fecha"),
    @NamedQuery(name = "Evolucion.findByReciboPago", query = "SELECT e FROM Evolucion e WHERE e.reciboPago = :reciboPago"),
    @NamedQuery(name = "Evolucion.findByTratamientoEjecutado", query = "SELECT e FROM Evolucion e WHERE e.tratamientoEjecutado = :tratamientoEjecutado")})
public class Evolucion implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idevolucion")
    private Integer idevolucion;
    @Column(name = "fecha")
    @Temporal(TemporalType.DATE)
    private Date fecha;
    @Column(name = "reciboPago")
    private String reciboPago;
    @Column(name = "tratamientoEjecutado")
    private String tratamientoEjecutado;
    @JoinColumn(name = "diagnostico_iddiagnostico", referencedColumnName = "iddiagnostico")
    @ManyToOne(optional = false)
    private Diagnostico diagnosticoIddiagnostico;

    public Evolucion() {
    }

    public Evolucion(Integer idevolucion) {
        this.idevolucion = idevolucion;
    }

    public Integer getIdevolucion() {
        return idevolucion;
    }

    public void setIdevolucion(Integer idevolucion) {
        this.idevolucion = idevolucion;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getReciboPago() {
        return reciboPago;
    }

    public void setReciboPago(String reciboPago) {
        this.reciboPago = reciboPago;
    }

    public String getTratamientoEjecutado() {
        return tratamientoEjecutado;
    }

    public void setTratamientoEjecutado(String tratamientoEjecutado) {
        this.tratamientoEjecutado = tratamientoEjecutado;
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
        hash += (idevolucion != null ? idevolucion.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Evolucion)) {
            return false;
        }
        Evolucion other = (Evolucion) object;
        if ((this.idevolucion == null && other.idevolucion != null) || (this.idevolucion != null && !this.idevolucion.equals(other.idevolucion))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.Evolucion[ idevolucion=" + idevolucion + " ]";
    }

}
