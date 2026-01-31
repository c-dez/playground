extends Enemy
class_name KatanaChan
# este enum podria representarse mejor con el arma que esta usando?
enum {
    REVOLVER,
    SWORD,
    BOTH
}
## enum {REVOLVER,AGRESSIVE}
var current_weapon:int= REVOLVER

# katana chan es arrogante, le gusta jugar con su presa, pero esta confianza es justificada
# es rival, tiene habilidades muy similares al player

# se mueve rapidamente , es dificil golpearla y constantemente ataca cuando esta agresiva, 

# pero cuando cambia a pasiva se mueve lentamente, y sus ataque son mas  limitados

#  usa tanto espada como revolver, y cambia entre ellos constantyemente

# espada/ se mueve rapidamente y attaca cuerpo a cuerpo, puede bloquear balas 

# revolver/ mantiene distancia, se mueve mas lentamente pero sus disparos son peligrosos

# podria dividir la pelea en fases, sin orden especifico en revolver, espada y los dos anteriores simultaneamente
    # esto podria dar pacing a la pelea
    # dar tiempo de aprender el moveset de cada arma
    # y en la ultima fase poner a prueba este conocimiento al mezclar ataques de los dos tipos

# fase espada
    # se mueve rapidamente
    # hace dash hacia player, poniendo areas en el suelo antes para mostrar donde va a atacar
        # punto debil, si el jugador lo esquiva puede girar 180 grados para dispararle por la espalda
    # bloquear balas
    # disengage, salto hacia atras para separarse
        # puede usarse para empezar otro ataque
        # complica el dispararle por la espalda despues de un dash