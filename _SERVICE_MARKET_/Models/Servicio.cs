namespace _SERVICE_MARKET_.Models
{
    public class Servicio
    {
        /*SERVICIO*/
        public int ID_SERVICIO { get; set; }
        public string NOMBRE_SER { get; set; }
        public decimal PRECIO_SER { get; set; }
        public string DESCRIPCION_BREVE { get; set; }
        public string TERMINOS_SER { get; set; }
        public string ESTADO_DS { get; set; }
        public string TIPO { get; set; }
        public string FECHA_PUBLICACION { get; set; }
        public string N_IDENTIFICACION_USU_FK { get; set; }
        public string N_IDENTIFICACION_ADMIN_FK { get; set; }
        public int ID_CATEGORIA_FK { get; set; }

        /*CATEGORIAS*/
        public int ID_CATEGORIA { get; set; }
        public string NOMBRE_CAT { get; set; }
        public string DESCRIPCION_CAT { get; set; }

        /*USUARIO*/
        public string N_IDENTIFICACION_USU { get; set; }
        public string NOMBRE_USU { get; set; }
        public string APELLIDOS_USU { get; set; }
        public string CELULAR_USU { get; set; }

        /*CIUDAD*/
        public string NOMBRE_CIUDAD { get; set; }
    }
}