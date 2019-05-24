import React from 'react'

import {
  requireNativeComponent,
} from 'react-native'

import PropTypes from 'prop-types'

// export default requireNativeComponent('RNVMyView')
const RNVMyView = requireNativeComponent('RNVMyView')

const MyView = (props)=>(
    <RNVMyView {...props}/>
)

MyView.propTypes = {
  userInteractionEnabled: PropTypes.bool.isRequired,
  text: PropTypes.string,
  textColor:PropTypes.string,
  fontSize: PropTypes.number,
  onClickHandler: PropTypes.func
}

MyView.defaultProps = {
  userInteractionEnabled: true,
  textColor: '#eee',
}

export default MyView

