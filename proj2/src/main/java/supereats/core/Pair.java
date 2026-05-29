package supereats.core;

public class Pair<K, V> {
    public final K key;
    public V value;

    public Pair(K key, V value) {
        this.key = key;
        this.value = value;
    }

    public K first() {
        return key;
    }

    public V second() {
        return value;
    }

    public void setSecond(V newValue) {
        this.value = newValue;
    }
}
