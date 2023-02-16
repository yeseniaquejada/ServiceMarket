namespace _SERVICE_MARKET_.Models
{
    public class Usuario
    {
        public string TIPO_DOC_USU { get; set; }
        public string N_IDENTIFICACION_USU { get; set; }
        public string FECHA_NACIMIENTO_USU { get; set; }
        public string FECHA_EXPEDICION_USU { get; set; }
        public string NOMBRE_USU { get; set; }
        public string APELLIDOS_USU { get; set; }
        public string CELULAR_USU { get; set; }
        public string GENERO_USU { get; set; }
        public int ID_CIUDAD_FK { get; set; }
        public string DIRECCION_USU { get; set; }
        public string CORREO_ELECTRONICO_USU { get; set; }
        public string CONTRASENA_USU { get; set; }
        public string CONFIRMAR_CONTRASENA { get; set; }
    }
}