﻿Public Class PaginasConocidas

    Public Shared ReadOnly DIR_ESCRITURA_APP As String = ConfigurationManager.AppSettings.Get("directorioEscritura").ToString

    Public Shared ReadOnly DIR_FRONT As String = "/Front/"
    Public Shared ReadOnly DIR_PAGES As String = "/Pages/"
    Public Shared ReadOnly ASPX As String = ".aspx"

    'Cuenta y acceso
    Public Shared ReadOnly HOME As String = DIR_FRONT + "Home" + ASPX
    Public Shared ReadOnly LOGIN As String = "/Pantalla_Login" + ASPX
    Public Shared ReadOnly REGISTRO As String = DIR_FRONT + "Registracion" + ASPX
    Public Shared ReadOnly RECUPERAR_CLAVE As String = DIR_FRONT + "RecuperarClave" + ASPX
    Public Shared ReadOnly TERMINOS As String = DIR_FRONT + "Terminos" + ASPX
    Public Shared ReadOnly POLITICAS As String = DIR_FRONT + "Politicas" + ASPX
    Public Shared ReadOnly MI_ERROR As String = DIR_FRONT + "MiError" + ASPX

    'Acceso comun
    Public Shared ReadOnly INSTITUCIONAL As String = DIR_FRONT + "Institucional" + ASPX
    Public Shared ReadOnly BUSQUEDA As String = DIR_PAGES + "Pantalla_Principal" + ASPX
    Public Shared ReadOnly CONTACTO As String = DIR_FRONT + "Contacto" + ASPX
    Public Shared ReadOnly NOVEDADES As String = DIR_FRONT + "Novedades" + ASPX
    Public Shared ReadOnly NEWSLETTER As String = DIR_FRONT + "Newsletter" + ASPX
    Public Shared ReadOnly FAQ As String = DIR_FRONT + "FAQ" + ASPX
    Public Shared ReadOnly ENCUESTAS As String = DIR_FRONT + "Encuestas" + ASPX

    Public Shared ReadOnly SITIOS_AFILIADOS As String = DIR_FRONT + "SitiosAfiliados" + ASPX
    Public Shared ReadOnly FORMAS_DE_PAGO As String = DIR_FRONT + "FormasDePago" + ASPX
    Public Shared ReadOnly NOTA_1 As String = DIR_FRONT + "Notas1" + ASPX
    Public Shared ReadOnly NOTA_2 As String = DIR_FRONT + "Notas2" + ASPX
    Public Shared ReadOnly NOTA_3 As String = DIR_FRONT + "Notas3" + ASPX

    'Catalogo
    Public Shared ReadOnly CATALOGO As String = DIR_PAGES + "Carreras" + ASPX
    Public Shared ReadOnly CATALOGO_DETALLE As String = DIR_PAGES + "CarrerasDetalle" + ASPX
    Public Shared ReadOnly COMPARACION As String = DIR_PAGES + "Comparacion" + ASPX
    Public Shared ReadOnly CARRITO As String = DIR_PAGES + "Carrito" + ASPX

    'Inscripcion
    Public Shared Property INSCRIPCION As String = DIR_PAGES + "Inscripcion" + ASPX
    Public Shared Property INSCRIPTO_CALIFICAR As String = DIR_PAGES + "InscriptoCalificacion" + ASPX

    'Alumno
    Public Shared Property CUENTA_CORRIENTE As String = DIR_PAGES + "CuentaCorriente" + ASPX
    Public Shared Property MI_CURSADA As String = DIR_PAGES + "MiCursada" + ASPX
    Public Shared Property EXAMENES_ALUMNOS As String = DIR_PAGES + "Examenes" + ASPX
    Public Shared Property RENDIR_EXAMEN As String = DIR_PAGES + "DetalleExamen" + ASPX
    Public Shared Property RESULTADO_EXAMEN As String = DIR_PAGES + "ExamenResultado" + ASPX
    Public Shared Property VISTA_MATERIAL As String = DIR_PAGES + "VistaMaterial" + ASPX

    'Profesor
    Public Shared Property MIS_CLASES As String = DIR_PAGES + "MisClases" + ASPX
    Public Shared Property EDICION_MATERIAL As String = DIR_PAGES + "EdicionMaterial" + ASPX
    Public Shared Property EDICION_EXAMEN As String = DIR_PAGES + "EdicionExamen" + ASPX
    Public Shared Property EXAMENES_CORRECION As String = DIR_PAGES + "ExamenesCorreccion" + ASPX
    Public Shared Property CORRECCION_EXAMEN As String = DIR_PAGES + "ExamenCorreccion" + ASPX

    'Acceso usuario
    Public Shared ReadOnly CAMBIAR_CLAVE As String = DIR_PAGES + "CambioClave" + ASPX
    Public Shared ReadOnly MENSAJES As String = DIR_PAGES + "Mensajes" + ASPX
    Public Shared Property FORO As String = DIR_PAGES + "Foro" + ASPX
    Public Shared Property STREAMING As String = DIR_PAGES + "Streaming" + ASPX

    'Empleado
    Public Shared Property PAGO As String = DIR_PAGES + "Pago" + ASPX
    Public Shared Property GESTION_COMPROBANTES As String = DIR_PAGES + "AbmComprobantes" + ASPX

    'Director
    Public Shared Property GESTION_CURSOS As String = DIR_PAGES + "AbmElementoAcademico" + ASPX
    Public Shared Property CONTENIDO_CURSOS As String = DIR_PAGES + "ContenidoElementoAcademico" + ASPX
    Public Shared Property ABM_NOVEDADES As String = DIR_PAGES + "AbmNovedades" + ASPX
    Public Shared Property ABM_ENCUESTAS As String = DIR_PAGES + "AbmEncuestas" + ASPX
    Public Shared Property ABM_FICHAS As String = DIR_PAGES + "AbmFichas" + ASPX
    Public Shared Property RESULTADOS_ENCUESTAS As String = DIR_PAGES + "ResultadosEncuestas" + ASPX
    Public Shared Property RESULTADOS_FICHAS As String = DIR_PAGES + "ResultadosFichas" + ASPX
    Public Shared Property ESTADISTICAS_RESPUESTA As String = DIR_PAGES + "EstadisticasRespuesta" + ASPX
    Public Shared Property GANANCIAS As String = DIR_PAGES + "Ganancias" + ASPX
    Public Shared Property SATISFACCION As String = DIR_PAGES + "Satisfaccion" + ASPX
    Public Shared Property GANANACIAS_COMPARATIVAS As String = DIR_PAGES + "GananciasComparativas" + ASPX

End Class
