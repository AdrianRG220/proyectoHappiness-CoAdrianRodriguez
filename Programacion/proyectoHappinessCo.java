import java.util.*;
import java.time.LocalDate;

public class proyectoHappinessCo {
    private static HashMap<String, Usuario> usuarios = new HashMap<>();
    private static HashMap<Integer, Evento> eventos = new HashMap<>();
    private static int contadorEvento = 0;
    private static int contadorGaleria = 0;
    private static ArrayList<Favorito> favoritos = new ArrayList<>();

    public static void main(String[] args) {
        Scanner teclado = new Scanner(System.in);
        int opcion = 0;

        do {
            mostrarMenu();
            System.out.print("Seleccione una opción: ");
            opcion = teclado.nextInt();
            teclado.nextLine();

            switch (opcion) {
                case 1: anadirUsuario(teclado); break;
                case 2: eliminarUsuario(teclado); break;
                case 3: anadirEvento(teclado); break;
                case 4: eliminarEvento(teclado); break;
                case 5: anadirGaleria(teclado); break;
                case 6: eliminarGaleria(teclado); break;
                case 7: anadirFavorito(teclado); break;
                case 8: eliminarFavorito(teclado); break;
                case 9: System.out.println("¡Gracias por usar HAPPINESS&CO!"); break;
                default: System.out.println("Opción no válida");
            }
        } while (opcion != 9);
    }

    private static void mostrarMenu() {
        System.out.println("\n--- MENU HAPPINESS&CO ---");
        System.out.println("1. Añadir usuario");
        System.out.println("2. Eliminar usuario");
        System.out.println("3. Añadir evento");
        System.out.println("4. Eliminar evento");
        System.out.println("5. Añadir galería");
        System.out.println("6. Eliminar galería");
        System.out.println("7. A�adir favorito");
        System.out.println("8. Eliminar favorito");
        System.out.println("9. Salir");
    }

    private static void anadirUsuario(Scanner teclado) {
        System.out.print("Nombre: ");
        String nombre = teclado.nextLine();
        System.out.print("Email: ");
        String email = teclado.nextLine();
        System.out.print("Password: ");
        String password = teclado.nextLine();

        if (usuarios.containsKey(email)) {
            System.out.println("El usuario ya existe");
        } else {
            Usuario nuevo = new Usuario(nombre, email, password);
            usuarios.put(email, nuevo);
            System.out.println("Usuario creado correctamente");
        }
    }

    private static void eliminarUsuario(Scanner teclado) {
        System.out.print("Correo del usuario a eliminar: ");
        String email = teclado.nextLine();

        if (usuarios.containsKey(email)) {
            usuarios.remove(email);
            for (int i = 0; i < favoritos.size(); i++) {
                if (favoritos.get(i).getCorreoUsuario().equals(email)) {
                    favoritos.remove(i);
                    i--;
                }
            }
            System.out.println("Usuario eliminado correctamente");
        } else {
            System.out.println("El usuario no existe");
        }
    }

    private static void anadirEvento(Scanner teclado) {
        System.out.print("Fecha (yyyy-mm-dd): ");
        String fechaStr = teclado.nextLine();
        LocalDate fecha = LocalDate.parse(fechaStr);
        
        System.out.print("Título: ");
        String titulo = teclado.nextLine();
        System.out.print("Ubicación: ");
        String ubi = teclado.nextLine();
        System.out.print("Descripción: ");
        String desc = teclado.nextLine();

        int id = contadorEvento;
        contadorEvento++;
        
        Evento nuevoEv = new Evento(id, fecha, titulo, ubi, desc);
        eventos.put(id, nuevoEv);
        System.out.println("Evento creado correctamente");
    }

    private static void eliminarEvento(Scanner teclado) {
        for (Evento e : eventos.values()) {
            System.out.println(e.toString());
        }

        System.out.print("ID del evento a eliminar: ");
        int id = teclado.nextInt();
        teclado.nextLine();

        if (eventos.containsKey(id)) {
            eventos.remove(id);
            for (int i = 0; i < favoritos.size(); i++) {
                if (favoritos.get(i).getIdEvento() == id) {
                    favoritos.remove(i);
                    i--;
                }
            }
            System.out.println("Evento eliminado correctamente");
        } else {
            System.out.println("El evento no existe");
        }
    }

    private static void anadirGaleria(Scanner teclado) {
        for (Evento e : eventos.values()) {
            System.out.println(e.toString());
        }
        System.out.print("ID del evento: ");
        int idEvento = teclado.nextInt();
        teclado.nextLine();

        if (!eventos.containsKey(idEvento)) {
            System.out.println("Error: ID incorrecto");
            return;
        }

        System.out.print("Título galería: ");
        String titulo = teclado.nextLine();
        
        int idGal = contadorGaleria;
        contadorGaleria++;

        Galeria g = new Galeria(idGal, titulo, idEvento);
        eventos.get(idEvento).getGaleriaList().add(g);
        System.out.println("Galería creada correctamente");
    }

    private static void eliminarGaleria(Scanner teclado) {
        for (Evento e : eventos.values()) {
            System.out.println(e.toString());
        }
        System.out.print("ID del evento: ");
        int idEvento = teclado.nextInt();
        teclado.nextLine();

        if (!eventos.containsKey(idEvento)) {
            System.out.println("ID incorrecto");
            return;
        }

        Evento ev = eventos.get(idEvento);
        ArrayList<Galeria> listaG = ev.getGaleriaList();

        for (Galeria g : listaG) {
            System.out.println(g.toString());
        }

        System.out.print("ID de la galería a eliminar: ");
        int idGal = teclado.nextInt();
        teclado.nextLine();

        boolean encontrada = false;
        for (int i = 0; i < listaG.size(); i++) {
            if (listaG.get(i).getId() == idGal) {
                listaG.remove(i);
                encontrada = true;
                break;
            }
        }

        if (encontrada) {
            System.out.println("Galería eliminada correctamente");
        } else {
            System.out.println("La galería no existe");
        }
    }

    private static void anadirFavorito(Scanner teclado) {
        System.out.println("--- Lista de Eventos ---");
        for (Evento e : eventos.values()) {
            System.out.println(e.toString());
        }
        System.out.println("--- Lista de Usuarios ---");
        for (Usuario u : usuarios.values()) {
            System.out.println(u.toString());
        }

        System.out.print("ID del evento: ");
        int idEvento = teclado.nextInt();
        teclado.nextLine();
        System.out.print("Correo de usuario: ");
        String email = teclado.nextLine();

        if (!eventos.containsKey(idEvento) || !usuarios.containsKey(email)) {
            System.out.println("Evento o correo incorrecto");
            return;
        }

        favoritos.add(new Favorito(email, idEvento));
        System.out.println("Favorito creado correctamente");
    }

    private static void eliminarFavorito(Scanner teclado) {
        for (Favorito f : favoritos) {
            System.out.println(f.toString());
        }
        
        System.out.print("ID del evento: ");
        int idEvento = teclado.nextInt();
        teclado.nextLine();
        System.out.print("Correo del usuario: ");
        String email = teclado.nextLine();

        boolean borrado = false;
        for (int i = 0; i < favoritos.size(); i++) {
            Favorito f = favoritos.get(i);
            if (f.getIdEvento() == idEvento && f.getCorreoUsuario().equals(email)) {
                favoritos.remove(i);
                borrado = true;
                break;
            }
        }

        if (borrado) {
            System.out.println("Favorito eliminado correctamente");
        } else {
            System.out.println("El favorito no existe");
        }
    }
}