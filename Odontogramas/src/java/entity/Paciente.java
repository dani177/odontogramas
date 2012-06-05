/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package entity;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;


@Entity
@Table(name = "paciente")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Paciente.findAll", query = "SELECT p FROM Paciente p"),
    @NamedQuery(name = "Paciente.findByIdpersona", query = "SELECT p FROM Paciente p WHERE p.idpersona = :idpersona"),
    @NamedQuery(name = "Paciente.findByNombre", query = "SELECT p FROM Paciente p WHERE p.nombre = :nombre"),
    @NamedQuery(name = "Paciente.findByDireccion", query = "SELECT p FROM Paciente p WHERE p.direccion = :direccion"),
    @NamedQuery(name = "Paciente.findByNumAfiliacion", query = "SELECT p FROM Paciente p WHERE p.numAfiliacion = :numAfiliacion"),
    @NamedQuery(name = "Paciente.findByTelefono", query = "SELECT p FROM Paciente p WHERE p.telefono = :telefono"),
    @NamedQuery(name = "Paciente.findByCiudad", query = "SELECT p FROM Paciente p WHERE p.ciudad = :ciudad"),
    @NamedQuery(name = "Paciente.findByEdad", query = "SELECT p FROM Paciente p WHERE p.edad = :edad"),
    @NamedQuery(name = "Paciente.findBySexo", query = "SELECT p FROM Paciente p WHERE p.sexo = :sexo"),
    @NamedQuery(name = "Paciente.findByEstadoCivil", query = "SELECT p FROM Paciente p WHERE p.estadoCivil = :estadoCivil"),
    @NamedQuery(name = "Paciente.findByOcupacion", query = "SELECT p FROM Paciente p WHERE p.ocupacion = :ocupacion"),
    @NamedQuery(name = "Paciente.findByRemitidoA", query = "SELECT p FROM Paciente p WHERE p.remitidoA = :remitidoA"),
    @NamedQuery(name = "Paciente.findByFecha", query = "SELECT p FROM Paciente p WHERE p.fecha = :fecha")})
public class Paciente implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "idpersona")
    private String idpersona;
    @Column(name = "nombre")
    private String nombre;
    @Column(name = "direccion")
    private String direccion;
    @Column(name = "num_afiliacion")
    private String numAfiliacion;
    @Column(name = "telefono")
    private String telefono;
    @Column(name = "ciudad")
    private String ciudad;
    @Column(name = "edad")
    private Integer edad;
    @Column(name = "sexo")
    private String sexo;
    @Column(name = "estadoCivil")
    private String estadoCivil;
    @Column(name = "ocupacion")
    private String ocupacion;
    @Column(name = "remitidoA")
    private String remitidoA;
    @Column(name = "fecha")
    @Temporal(TemporalType.DATE)
    private Date fecha;
    @ManyToMany(mappedBy = "pacienteCollection")
    private Collection<Medico> medicoCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "pacienteidpersona")
    private Collection<Examenfisicoestomatologico> examenfisicoestomatologicoCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "pacienteIdpersona")
    private Collection<Diagnostico> diagnosticoCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "pacienteIdpersona")
    private Collection<Datosconsulta> datosconsultaCollection;

    public Paciente() {
    }

    public Paciente(String idpersona) {
        this.idpersona = idpersona;
    }

    public String getIdpersona() {
        return idpersona;
    }

    public void setIdpersona(String idpersona) {
        this.idpersona = idpersona;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getNumAfiliacion() {
        return numAfiliacion;
    }

    public void setNumAfiliacion(String numAfiliacion) {
        this.numAfiliacion = numAfiliacion;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public Integer getEdad() {
        return edad;
    }

    public void setEdad(Integer edad) {
        this.edad = edad;
    }

    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    public String getEstadoCivil() {
        return estadoCivil;
    }

    public void setEstadoCivil(String estadoCivil) {
        this.estadoCivil = estadoCivil;
    }

    public String getOcupacion() {
        return ocupacion;
    }

    public void setOcupacion(String ocupacion) {
        this.ocupacion = ocupacion;
    }

    public String getRemitidoA() {
        return remitidoA;
    }

    public void setRemitidoA(String remitidoA) {
        this.remitidoA = remitidoA;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    @XmlTransient
    public Collection<Medico> getMedicoCollection() {
        return medicoCollection;
    }

    public void setMedicoCollection(Collection<Medico> medicoCollection) {
        this.medicoCollection = medicoCollection;
    }

    @XmlTransient
    public Collection<Examenfisicoestomatologico> getExamenfisicoestomatologicoCollection() {
        return examenfisicoestomatologicoCollection;
    }

    public void setExamenfisicoestomatologicoCollection(Collection<Examenfisicoestomatologico> examenfisicoestomatologicoCollection) {
        this.examenfisicoestomatologicoCollection = examenfisicoestomatologicoCollection;
    }

    @XmlTransient
    public Collection<Diagnostico> getDiagnosticoCollection() {
        return diagnosticoCollection;
    }

    public void setDiagnosticoCollection(Collection<Diagnostico> diagnosticoCollection) {
        this.diagnosticoCollection = diagnosticoCollection;
    }

    @XmlTransient
    public Collection<Datosconsulta> getDatosconsultaCollection() {
        return datosconsultaCollection;
    }

    public void setDatosconsultaCollection(Collection<Datosconsulta> datosconsultaCollection) {
        this.datosconsultaCollection = datosconsultaCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idpersona != null ? idpersona.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Paciente)) {
            return false;
        }
        Paciente other = (Paciente) object;
        if ((this.idpersona == null && other.idpersona != null) || (this.idpersona != null && !this.idpersona.equals(other.idpersona))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.Paciente[ idpersona=" + idpersona + " ]";
    }

}
