import React, { Component }from 'react'
import {
  StyleSheet,
  View,
  TouchableOpacity,
  Text,
  NativeModules,
} from 'react-native'

let count = 0

export class RNPageThree extends Component {
  // constructor(props){
  //   super(props)
  //   this.state = {count: 0}
  // }

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.text}>RNPageThree</Text>
        <TouchableOpacity
            style={styles.button}
            onPress={_=>NativeModules.RNPageViewController.goBack()}
        >
          <Text style={styles.buttonText}>Go Back</Text>
        </TouchableOpacity>
        <TouchableOpacity
            style={styles.button}
            onPress={_=>{
              // console.log(this.state)
              // const count = this.state.count++
              // this.setState({count})
              // console.log(this.state)
              count++
              const nativeManager = NativeModules.RNPageViewController
              nativeManager.rnButtonClicked(count)
            }}
        >
          <Text style={styles.buttonText}>Click Me</Text>
        </TouchableOpacity>
      </View>
    )
  }
}


// export const RNPageThree = ()=>(
//     <View style={styles.container}>
//       <Text style={styles.text}>RNPageThree</Text>
//       <TouchableOpacity
//           style={styles.button}
//           onPress={_=>nativeManager.goBack()}
//       >
//         <Text style={styles.buttonText}>Call a native without Parameters</Text>
//       </TouchableOpacity>
//       <TouchableOpacity
//           style={styles.button}
//           onPress={_=>nativeManager.goBack()}
//       >
//         <Text style={styles.buttonText}>Call a native with Parameters</Text>
//       </TouchableOpacity>
//     </View>
// )

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
    marginHorizontal: 20,
    marginVertical: 10,
    padding: 10,
    backgroundColor: '#44e',
    borderRadius: 5,
  },

  buttonText: {
    color: '#fff',
    textAlign: 'center',
  },

})
