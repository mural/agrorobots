Imports DTO

Public Class Entrevistas

    Public Shared Function traerCandidatos(ByRef perfil As Perfil) As List(Of Candidato)
        Dim dinamCandidatos As New Candidato_Business
        'Dim lst As List(Of Candidato)

        Return dinamCandidatos.obtenerSegunPerfil(perfil)
    End Function

End Class
