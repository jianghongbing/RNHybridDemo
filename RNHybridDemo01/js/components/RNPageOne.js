import React from 'react'

import {
  StyleSheet,
  View,
  Text,
} from 'react-native'

export const RNPageOne = ()=>(
    <View style={styles.container}>
      <Text style={styles.text}>RNPageOne</Text>
    </View>
)

const styles = StyleSheet.create({
  container: {
    backgroundColor: 'orange',
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  text: {
    color: '#eee',
    fontSize: 35,
    fontWeight: 'bold',
  }
})