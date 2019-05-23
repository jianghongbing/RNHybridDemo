import React from 'react'
import {
  StyleSheet,
  View,
  TouchableOpacity,
  Text,
  NativeModules,
} from 'react-native'

const nativeManager = NativeModules.RNPageViewController
export const RNPageThree = ()=>(
    <View style={styles.container}>
      <Text style={styles.text}>RNPageThree</Text>
      <TouchableOpacity
          style={styles.button}
          onPress={_=>nativeManager.goBack()}
      >
        <Text style={styles.buttonText}>Go Back</Text>
      </TouchableOpacity>
    </View>
)

const styles = StyleSheet.create({
  container:{
    flex: 1,
    justifyContent: 'center',
  },
  text: {
    color: 'orange',
    fontSize: 35,
    alignSelf: 'center',
  },

  button: {
    margin: 20,
    padding: 10,
    backgroundColor: '#44e',
    borderRadius: 5,
  },

  buttonText: {
    color: '#fff',
    textAlign: 'center',
  },

})
