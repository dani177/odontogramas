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
@Table(name = "diente")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Diente.findAll", query = "SELECT d FROM Diente d"),
    @NamedQuery(name = "Diente.findByIddiente", query = "SELECT d FROM Diente d WHERE d.iddiente = :iddiente"),
    @NamedQuery(name = "Diente.findByNombre", query = "SELECT d FROM Diente d WHERE d.nombre = :nombre")})
public class Diente implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "iddiente")
    private Integer iddiente;
    @Column(name = "nombre")
    private String nombre;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "diente")
    private List<DatosconsultaHasDiente> datosconsultaHasDienteList;

    public Diente() {
    }

    public Diente(Integer iddiente) {
        this.iddiente = iddiente;
    }

    public Integer getIddiente() {
        return iddiente;
    }

    public void setIddiente(Integer iddiente) {
        this.iddiente = iddiente;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    @XmlTransient
    public List<DatosconsultaHasDiente> getDatosconsultaHasDienteList() {
        return datosconsultaHasDienteList;
    }

    public void setDatosconsultaHasDienteList(List<DatosconsultaHasDiente> datosconsultaHasDienteList) {
        this.datosconsultaHasDienteList = datosconsultaHasDienteList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (iddiente != null ? iddiente.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Diente)) {
            return false;
        }
        Diente other = (Diente) object;
        if ((this.iddiente == null && other.iddiente != null) || (this.iddiente != null && !this.iddiente.equals(other.iddiente))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.Diente[ iddiente=" + iddiente + " ]";
    }

}
