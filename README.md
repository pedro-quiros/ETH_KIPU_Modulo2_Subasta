# ETH KIPU - Trabajo Práctico Módulo 2 | Subasta: Smart Contract

## Descripción
Este contrato implementa una subasta con las siguientes características:
- Solo el propietario puede finalizar la subasta.
- Las ofertas deben superar al mejor oferente en al menos un 5%.
- Si una oferta válida se realiza en los últimos 10 minutos, el tiempo se extiende 10 minutos más.
- Los participantes pueden retirar sus excedentes de ofertas anteriores.
- Un usuario no puede ofertar dos veces seguidas.

## Variables principales

| Variable             | Descripción                                         |
|----------------------|----------------------------------------------------|
| `owner`              | Dirección del creador/propietario de la subasta.  |
| `mejorOferente`      | Dirección del mejor oferente actual.                |
| `mejorOfertaMonto`   | Monto de la mejor oferta actual.                    |
| `finSubastaTiempo`   | Timestamp que indica cuándo finaliza la subasta.   |
| `COMISION_PORCENTAJE`| Comisión fija del 2% aplicada al ganador.           |
| `estaFinalizada`     | Booleano que indica si la subasta fue finalizada.  |

## Funciones principales

- `ofertar()`: Permite realizar una oferta si supera el mínimo establecido.
- `finalizarSubasta()`: Solo el propietario puede finalizar y recibir la comisión.
- `reembolsar()`: Permite a los no ganadores retirar sus fondos luego de finalizada la subasta.
- `verGanador()`: Devuelve el mejor oferente y la mejor oferta.
- `verOfertas(address)`: Permite ver las ofertas realizadas por un usuario.
- `retirarExcedente()`: Permite retirar ofertas anteriores al mejor monto.

## Eventos

- `OfertaRealizada(address, uint256)`: Se emite cuando un usuario realiza una oferta válida.
- `SubastaFinalizada(address, uint256)`: Se emite cuando el propietario finaliza la subasta.

---

## Uso

Para usar el contrato:

1. Desplegar el contrato en la red deseada.
2. Invocar `ofertar()` con un valor en `msg.value` que supere el mínimo establecido.
3. El propietario debe llamar a `finalizarSubasta()` después del tiempo límite para cerrar la subasta y recibir la comisión.
4. Los participantes que no ganaron pueden llamar a `reembolsar()` para recuperar sus fondos.
5. Los participantes pueden usar `retirarExcedente()` para retirar ofertas anteriores que no son la mejor actual.

---

## Recursos útiles

- [Conversor ETH a USD y otras criptomonedas](https://eth-converter.com/) — Para verificar valores y conversiones de Ether en tiempo real.
- [Convertidor de Unix Timestamp](https://www.unixtimestamp.com/) — Para interpretar y convertir timestamps usados en el contrato (como `finSubastaTiempo`).

---

## Autor

Pedro Quirós — pedrobquiros@gmail.com
