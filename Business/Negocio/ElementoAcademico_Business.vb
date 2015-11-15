Imports EE
Imports MPP
Imports EE.ElementoAcademico

Public Class ElementoAcademico_Business
    Inherits Business(Of ElementoAcademico)

    Dim usuarioMapper As New Usuario_Data
    Dim alumnoElementoAcademicoMapper As New AlumnoElementoAcademico_Mapper
    Dim profesorElementoAcademicoMapper As New ProfesorElementoAcademico_Mapper
    Dim alumnoMaterialDeEstudioMapper As New AlumnoMaterialDeEstudio_Mapper
    Dim materialDeEstudioBusiness As New MaterialDeEstudio_Business

    Sub New()
        Me.mapperGenerico = New ElementoAcademico_Mapper
    End Sub

    Public Overrides Function Listar() As List(Of ElementoAcademico)
        Dim elementosAcademicos As New List(Of ElementoAcademico)
        For Each elementoAcademico In mapperGenerico.Listar()
            Dim profesorElementoAcademico = ObtenerProfesorElementoAcademico(elementoAcademico.CodigoAcademico)
            If Not profesorElementoAcademico Is Nothing Then
                elementoAcademico.Profesor = usuarioMapper.ConsultarPorId(profesorElementoAcademico.IdProfesor)
            End If
            elementosAcademicos.Add(elementoAcademico)
        Next
        Return elementosAcademicos
    End Function

    Public Shadows Function ListarPorEstado(ByVal estado As ElementoAcademicoEnum, Optional ByVal incluirRechazados As Boolean = False) As List(Of ElementoAcademico)
        Dim elementosAcademicos As New List(Of ElementoAcademico)
        For Each elementoAcademico In Listar()
            If elementoAcademico.EstadoActual = estado Then
                elementosAcademicos.Add(elementoAcademico)
            End If
            If incluirRechazados And elementoAcademico.EstadoActual = ElementoAcademicoEnum.ConContenidoRechazado Then
                elementosAcademicos.Add(elementoAcademico)
            End If
        Next
        Return elementosAcademicos
    End Function

    Public Shadows Function ListarPorEstadoAsignadosProfesor(ByVal idProfesor As ElementoAcademicoEnum) As List(Of ElementoAcademico)
        Dim elementosAcademicos As New List(Of ElementoAcademico)
        For Each elementoAcademico In ListarPorEstado(ElementoAcademicoEnum.SinContenido, True)
            If Not elementoAcademico.Profesor Is Nothing Then
                If elementoAcademico.Profesor.ID = idProfesor Then
                    elementosAcademicos.Add(elementoAcademico)
                End If
            End If
        Next
        Return elementosAcademicos
    End Function

    Public Sub Inscribir(idUsuario As Integer, idElementoAcademico As String, activo As Boolean)
        Dim alumnoElementoAcademico = New AlumnoElementoAcademico
        alumnoElementoAcademico.ID = 0
        alumnoElementoAcademico.IdAlumno = idUsuario
        alumnoElementoAcademico.IdElementoAcademico = idElementoAcademico
        alumnoElementoAcademico.Activo = activo
        alumnoElementoAcademicoMapper.Insertar(alumnoElementoAcademico)

        Dim elementoAcademico = Obtener(idElementoAcademico)
        elementoAcademico.Cupo = elementoAcademico.Cupo - 1
        Actualizar(elementoAcademico)
    End Sub

    Public Sub Desinscribir(idUsuario As Integer, idElementoAcademico As String)
        For Each alumnoElementoAcademico In alumnoElementoAcademicoMapper.Listar
            If alumnoElementoAcademico.IdAlumno = idUsuario And alumnoElementoAcademico.IdElementoAcademico = idElementoAcademico Then
                alumnoElementoAcademicoMapper.Borrar(alumnoElementoAcademico.ID)
                Exit For
            End If
        Next

        Dim elementoAcademico = Obtener(idElementoAcademico)
        elementoAcademico.Cupo = elementoAcademico.Cupo + 1
        Actualizar(elementoAcademico)
    End Sub

    Public Sub ActivarInscripcion(idUsuario As Integer, idElementoAcademico As Integer)
        Dim alumnoElementoAcademico = New AlumnoElementoAcademico
        For Each alumnoElementoAcademicoBuscado In alumnoElementoAcademicoMapper.Listar
            If alumnoElementoAcademicoBuscado.IdAlumno = idUsuario And alumnoElementoAcademicoBuscado.IdElementoAcademico = idElementoAcademico Then
                alumnoElementoAcademico = alumnoElementoAcademicoBuscado
                Exit For
            End If
        Next
        alumnoElementoAcademico.Activo = True
        alumnoElementoAcademicoMapper.Actualizar(alumnoElementoAcademico)
    End Sub

    Public Function ObtenerPorAlumno(ByVal idUsuario As Integer) As List(Of ElementoAcademico)
        Dim elementosAcademicos As New List(Of ElementoAcademico)
        For Each alumnoElementoAcademico In alumnoElementoAcademicoMapper.Listar()
            If alumnoElementoAcademico.Activo = True And alumnoElementoAcademico.IdAlumno = idUsuario Then

                Dim clasesAcontar = 0
                Dim asistencias = 0
                For Each material In materialDeEstudioBusiness.ListarPorElementoAcademico(alumnoElementoAcademico.IdElementoAcademico)
                    clasesAcontar += 1
                    For Each alumnoMaterial In alumnoMaterialDeEstudioMapper.Listar
                        If alumnoMaterial.VistoEnTiempo And alumnoMaterial.IdAlumno = idUsuario And alumnoMaterial.IdMaterialDeEstudio = material.ID Then
                            asistencias += 1
                        End If
                    Next
                Next
                alumnoElementoAcademico.Presentismo = 100 'si no hay material de estudio todavia
                If clasesAcontar > 0 Then
                    alumnoElementoAcademico.Presentismo = (asistencias / clasesAcontar) * 100
                End If
                If alumnoElementoAcademico.Presentismo > 100 Then
                    alumnoElementoAcademico.Presentismo = 100 'si vio mas material del necesario
                End If
                alumnoElementoAcademicoMapper.Actualizar(alumnoElementoAcademico)

                Dim elementoAcademico = Obtener(alumnoElementoAcademico.IdElementoAcademico)
                elementoAcademico.AlumoEstado = alumnoElementoAcademico
                elementosAcademicos.Add(elementoAcademico)
            End If
        Next
        Return elementosAcademicos
    End Function

    Public Function ObtenerPorProfesor(ByVal idUsuario As Integer) As List(Of ElementoAcademico)
        Dim elementosAcademicos As New List(Of ElementoAcademico)
        For Each profesorElementoAcademico In profesorElementoAcademicoMapper.Listar()
            If profesorElementoAcademico.IdProfesor = idUsuario Then
                elementosAcademicos.Add(Obtener(profesorElementoAcademico.IdElementoAcademico))
            End If
        Next
        Return elementosAcademicos
    End Function

    Public Function ObtenerProfesorElementoAcademico(ByVal codigoAcademico As Integer) As ProfesorElementoAcademico
        For Each profesorElementoAcademico In profesorElementoAcademicoMapper.Listar()
            If profesorElementoAcademico.IdElementoAcademico = codigoAcademico Then
                Return profesorElementoAcademico
            End If
        Next
        Return Nothing
    End Function

    Public Function ActualizarConProfesor(elementoAcademico As ElementoAcademico) As Boolean
        Dim profesorElementoAcademico = ObtenerProfesorElementoAcademico(elementoAcademico.CodigoAcademico)
        If profesorElementoAcademico Is Nothing Then
            CrearProfesorElementoAcademico(elementoAcademico)
        Else
            If elementoAcademico.Profesor Is Nothing Then
                profesorElementoAcademico.IdProfesor = 0
            Else
                profesorElementoAcademico.IdProfesor = elementoAcademico.Profesor.ID
            End If
            profesorElementoAcademico.IdElementoAcademico = elementoAcademico.CodigoAcademico
            profesorElementoAcademicoMapper.Actualizar(profesorElementoAcademico)
        End If
        Return Me.Actualizar(elementoAcademico)
    End Function

    Public Function CrearConProfesor(elementoAcademico As ElementoAcademico) As Boolean
        CrearProfesorElementoAcademico(elementoAcademico)
        Return Me.Crear(elementoAcademico)
    End Function

    Private Sub CrearProfesorElementoAcademico(elementoAcademico As ElementoAcademico)
        Dim profesor As New ProfesorElementoAcademico
        profesor.ID = 0
        profesor.IdElementoAcademico = elementoAcademico.CodigoAcademico
        profesor.IdProfesor = elementoAcademico.Profesor.ID
        profesorElementoAcademicoMapper.Insertar(profesor)
    End Sub

    Public Function ActualizarPresentismo(ByRef alumno As Usuario, ByRef materialDeEstudio As MaterialDeEstudio) As Boolean
        Dim alumnoMaterialBuscado = Nothing
        For Each alumnoMaterial In alumnoMaterialDeEstudioMapper.Listar
            If alumnoMaterial.IdMaterialDeEstudio = materialDeEstudio.ID And alumnoMaterial.IdAlumno = alumno.ID Then
                alumnoMaterialBuscado = alumnoMaterial
                Exit For
            End If
        Next
        'si ya existe lo dejo como esta sino lo creo
        If alumnoMaterialBuscado Is Nothing Then
            Dim nuevoAlumnoMaterial As New AlumnoMaterialDeEstudio
            nuevoAlumnoMaterial.IdAlumno = alumno.ID
            nuevoAlumnoMaterial.IdMaterialDeEstudio = materialDeEstudio.ID
            nuevoAlumnoMaterial.VistoEnTiempo = False
            If Date.Now < materialDeEstudio.FechaMaxVisita Then
                nuevoAlumnoMaterial.VistoEnTiempo = True
            End If
            alumnoMaterialDeEstudioMapper.Insertar(nuevoAlumnoMaterial)

            alumno.ElementosAcademicos.Clear()
            alumno.ElementosAcademicos = ObtenerPorAlumno(alumno.ID)
            Return True
        End If
        Return False
    End Function

End Class
