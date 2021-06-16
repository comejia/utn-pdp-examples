module Library where
import PdePreludat

data Libro = Libro {
 titulo :: String,
 paginas :: Number,
 temas :: [String]
} deriving (Show)

masPaginasQue :: Libro -> Number -> Bool
masPaginasQue libro minimo = (>minimo).paginas $ libro

librosOrdenados:: [Libro] -> Bool
librosOrdenados [unLibro] = True
librosOrdenados (primerLibro:segundoLibro:proximosLibros) = 
    paginas primerLibro < paginas segundoLibro && librosOrdenados(segundoLibro:proximosLibros)

librosConMasPaginasQue:: Number -> [Libro] -> [String]
librosConMasPaginasQue minimo lista = (map titulo . filter (flip masPaginasQue minimo)) lista
