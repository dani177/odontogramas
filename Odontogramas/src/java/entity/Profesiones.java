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

/**
 *
 * @author Oscar
 */
@Entity
@Table(name = "profesiones")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Profesiones.findAll", query = "SELECT p FROM Profesiones p"),
    @NamedQuery(name = "Profesiones.findByProfesion", query = "SELECT p FROM Profesiones p WHERE p.profesion = :profesion"),
    @NamedQuery(name = "Profesiones.findByCodigo", query = "SELECT p FROM Profesiones p WHERE p.codigo = :codigo")})
public class Profesiones implements Serializable {
    private static final long serialVersionUID = 1L;
    @Column(name = "profesion")
    private String profesion;
    @Id
    @Basic(optional = false)
    @Column(name = "codigo")
    private Integer codigo;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "profesionesCodigo")
    private List<Paciente> pacienteList;

    public Profesiones() {
    }

    public Profesiones(Integer codigo) {
        this.codigo = codigo;
    }

    public String getProfesion() {
        return profesion;
    }

    public void setProfesion(String profesion) {
        this.profesion = profesion;
    }

    public Integer getCodigo() {
        return codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    @XmlTransient
    public List<Paciente> getPacienteList() {
        return pacienteList;
    }

    public void setPacienteList(List<Paciente> pacienteList) {
        this.pacienteList = pacienteList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (codigo != null ? codigo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Profesiones)) {
            return false;
        }
        Profesiones other = (Profesiones) object;
        if ((this.codigo == null && other.codigo != null) || (this.codigo != null && !this.codigo.equals(other.codigo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.Profesiones[ codigo=" + codigo + " ]";
    }
    
}
