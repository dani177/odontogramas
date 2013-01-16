/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Oscar Ballesteros
 */
@Entity
@Table(name = "evolucion")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Evolucion.findAll", query = "SELECT e FROM Evolucion e"),
    @NamedQuery(name = "Evolucion.findByIdevolucion", query = "SELECT e FROM Evolucion e WHERE e.idevolucion = :idevolucion"),
    @NamedQuery(name = "Evolucion.findByFecha", query = "SELECT e FROM Evolucion e WHERE e.fecha = :fecha"),
    @NamedQuery(name = "Evolucion.findByReciboPago", query = "SELECT e FROM Evolucion e WHERE e.reciboPago = :reciboPago"),
    @NamedQuery(name = "Evolucion.findByAbono", query = "SELECT e FROM Evolucion e WHERE e.abono = :abono"),
    @NamedQuery(name = "Evolucion.findBySaldo", query = "SELECT e FROM Evolucion e WHERE e.saldo = :saldo")})
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
    @Column(name = "abono")
    private Integer abono;
    @Column(name = "saldo")
    private String saldo;
    @JoinColumn(name = "tratamiento_idtratamiento", referencedColumnName = "idtratamiento")
    @ManyToOne(optional = false)
    private Tratamiento tratamientoIdtratamiento;

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

    public Integer getAbono() {
        return abono;
    }

    public void setAbono(Integer abono) {
        this.abono = abono;
    }

    public String getSaldo() {
        return saldo;
    }

    public void setSaldo(String saldo) {
        this.saldo = saldo;
    }

    public Tratamiento getTratamientoIdtratamiento() {
        return tratamientoIdtratamiento;
    }

    public void setTratamientoIdtratamiento(Tratamiento tratamientoIdtratamiento) {
        this.tratamientoIdtratamiento = tratamientoIdtratamiento;
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
