/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
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
    @NamedQuery(name = "Paciente.findByEdad", query = "SELECT p FROM Paciente p WHERE p.edad = :edad"),
    @NamedQuery(name = "Paciente.findBySexo", query = "SELECT p FROM Paciente p WHERE p.sexo = :sexo"),
    @NamedQuery(name = "Paciente.findByEstadoCivil", query = "SELECT p FROM Paciente p WHERE p.estadoCivil = :estadoCivil"),
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
    @Column(name = "edad")
    private Integer edad;
    @Column(name = "sexo")
    private String sexo;
    @Column(name = "estadoCivil")
    private String estadoCivil;
    @Column(name = "fecha")
    @Temporal(TemporalType.DATE)
    private Date fecha;
    @ManyToMany(mappedBy = "pacienteList")
    private List<Medico> medicoList;
    @JoinTable(name = "paciente_has_plantratamiento", joinColumns = {
        @JoinColumn(name = "paciente_idpersona", referencedColumnName = "idpersona")}, inverseJoinColumns = {
        @JoinColumn(name = "planTratamiento_idplanTratamiento", referencedColumnName = "idplanTratamiento")})
    @ManyToMany
    private List<Plantratamiento> plantratamientoList;
    @JoinTable(name = "paciente_has_tratamiento", joinColumns = {
        @JoinColumn(name = "paciente_idpersona", referencedColumnName = "idpersona")}, inverseJoinColumns = {
        @JoinColumn(name = "tratamiento_idtratamiento", referencedColumnName = "idtratamiento")})
    @ManyToMany
    private List<Tratamiento> tratamientoList;
    @JoinTable(name = "paciente_has_diagnostico", joinColumns = {
        @JoinColumn(name = "paciente_idpersona", referencedColumnName = "idpersona")}, inverseJoinColumns = {
        @JoinColumn(name = "diagnostico_iddiagnostico", referencedColumnName = "iddiagnostico")})
    @ManyToMany
    private List<Diagnostico> diagnosticoList;
    @JoinColumn(name = "profesiones_codigo", referencedColumnName = "codigo")
    @ManyToOne(optional = false)
    private Profesiones profesionesCodigo;
    @JoinColumn(name = "municipios_codigo", referencedColumnName = "codigo")
    @ManyToOne(optional = false)
    private Municipios municipiosCodigo;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "pacienteidpersona")
    private List<Examenfisicoestomatologico> examenfisicoestomatologicoList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "pacienteIdpersona")
    private List<Datosconsulta> datosconsultaList;

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

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    @XmlTransient
    public List<Medico> getMedicoList() {
        return medicoList;
    }

    public void setMedicoList(List<Medico> medicoList) {
        this.medicoList = medicoList;
    }

    @XmlTransient
    public List<Plantratamiento> getPlantratamientoList() {
        return plantratamientoList;
    }

    public void setPlantratamientoList(List<Plantratamiento> plantratamientoList) {
        this.plantratamientoList = plantratamientoList;
    }

    @XmlTransient
    public List<Tratamiento> getTratamientoList() {
        return tratamientoList;
    }

    public void setTratamientoList(List<Tratamiento> tratamientoList) {
        this.tratamientoList = tratamientoList;
    }

    @XmlTransient
    public List<Diagnostico> getDiagnosticoList() {
        return diagnosticoList;
    }

    public void setDiagnosticoList(List<Diagnostico> diagnosticoList) {
        this.diagnosticoList = diagnosticoList;
    }

    public Profesiones getProfesionesCodigo() {
        return profesionesCodigo;
    }

    public void setProfesionesCodigo(Profesiones profesionesCodigo) {
        this.profesionesCodigo = profesionesCodigo;
    }

    public Municipios getMunicipiosCodigo() {
        return municipiosCodigo;
    }

    public void setMunicipiosCodigo(Municipios municipiosCodigo) {
        this.municipiosCodigo = municipiosCodigo;
    }

    @XmlTransient
    public List<Examenfisicoestomatologico> getExamenfisicoestomatologicoList() {
        return examenfisicoestomatologicoList;
    }

    public void setExamenfisicoestomatologicoList(List<Examenfisicoestomatologico> examenfisicoestomatologicoList) {
        this.examenfisicoestomatologicoList = examenfisicoestomatologicoList;
    }

    @XmlTransient
    public List<Datosconsulta> getDatosconsultaList() {
        return datosconsultaList;
    }

    public void setDatosconsultaList(List<Datosconsulta> datosconsultaList) {
        this.datosconsultaList = datosconsultaList;
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
