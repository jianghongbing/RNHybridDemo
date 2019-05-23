import React from 'react'
import {
  StyleSheet,
  SafeAreaView,
  Text,
} from 'react-native'

export const RNPageTwo = ({name, age, id})=>(
     <SafeAreaView style={styles.container}>
       <Text style={styles.text}>{`name:${name}`}</Text>
       <Text style={styles.text}>{`age:${age}`}</Text>
       <Text style={styles.text}>{`id:${id}`}</Text>
     </SafeAreaView>
)

const styles = StyleSheet.create({
  container: {
    backgroundColor: 'red',
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  text: {
    fontSize: 20,
    color: '#fff',
    fontWeight: 'bold',
  }
})

