class Naturales:
    def __init__(self, value):
        if value < 0:
            raise ValueError("Los números naturales no pueden ser negativos")
        self.value = value

    def add(self, other):
        return Naturales(self.value + other.value)

    def mul(self, other):
        return Naturales(self.value * other.value)

    def is_additive_inverse(self, other):
        return self.value + other.value == 0

    def is_multiplicative_inverse(self, other):
        if self.value == 0:
            return False
        return self.value * other.value == 1

# Creación de números naturales
a = Naturales(2)
b = Naturales(3)

# Suma y multiplicación
print("Suma:", a.add(b).value)  # Resultado: 5
print("Multiplicación:", a.mul(b).value)  # Resultado: 6

# Verificación de inverso aditivo (no existe en naturales para a != 0)
c = Naturales(0)
print("¿Es inverso aditivo?", a.is_additive_inverse(c))  # Falso para a != 0

# Verificación de inverso multiplicativo (no existe en naturales para a != 1)
print("¿Es inverso multiplicativo?", a.is_multiplicative_inverse(b))  # Falso
