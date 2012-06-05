/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package entity;

import java.io.Serializable;
import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;


@Entity
@Table(name = "datosbasicos")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Datosbasicos.findAll", query = "SELECT d FROM Datosbasicos d"),
    @NamedQuery(name = "Datosbasicos.findByIddatosBasicos", query = "SELECT d FROM Datosbasicos d WHERE d.iddatosBasicos = :iddatosBasicos"),
    @NamedQuery(name = "Datosbasicos.findByNombre", query = "SELECT d FROM Datosbasicos d WHERE d.nombre = :nombre")})
public class Datosbasicos implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "iddatosBasicos")
    private Integer iddatosBasicos;
    @Column(name = "nombre")
    private String nombre;

    public Datosbasicos() {
    }

    public Datosbasicos(Integer iddatosBasicos) {
        this.iddatosBasicos = iddatosBasicos;
    }

    public Integer getIddatosBasicos() {
        return iddatosBasicos;
    }

    public void setIddatosBasicos(Integer iddatosBasicos) {
        this.iddatosBasicos = iddatosBasicos;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (iddatosBasicos != null ? iddatosBasicos.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Datosbasicos)) {
            return false;
        }
        Datosbasicos other = (Datosbasicos) object;
        if ((this.iddatosBasicos == null && other.iddatosBasicos != null) || (this.iddatosBasicos != null && !this.iddatosBasicos.equals(other.iddatosBasicos))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.Datosbasicos[ iddatosBasicos=" + iddatosBasicos + " ]";
    }

}
