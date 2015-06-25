Imports DAL
Imports System.Transactions
Imports DTO

Public Class Candidato_Business
    Implements ICandidato_Business

    Public Function obtenerSegunPerfil(ByRef perfil As DTO.Perfil) As List(Of DTO.Candidato) Implements ICandidato_Business.obtenerSegunPerfil

        Dim dataCandidato As New Candidato_Data
        Dim candidatos = dataCandidato.ObtenerCandidatos
        Dim perfiles As New Perfil_Business
        Dim capacidades As New Capacidad_Business
        Dim candidatosFiltrados As New List(Of DTO.Candidato)

        For Each candidato As Candidato In candidatos
            Dim capacidad = capacidades.ObtenerCapacidadPorPerfilYTipo(candidato.Perfil.ID, perfil.Capacidades.Item(0).Descripcion)
            Dim capacidadLista = New List(Of Capacidad)
            capacidadLista.Add(capacidad)
            candidato.Perfil.Capacidades = capacidadLista
            If perfiles.similitud(perfil, candidato.Perfil) > 0.75 Then
                candidatosFiltrados.Add(candidato)
            End If
        Next

        Return candidatosFiltrados
    End Function

End Class
