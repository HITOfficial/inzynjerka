import React from 'react';
import {
  BrowserRouter as Router,
  Route,
  Switch,
  useRouteMatch,
} from 'react-router-dom';
import ModelSettings from './model-settings/ModelSettings';
import QAndAPage from './q-and-a/QAndAPage';
import {Box} from 'theme-ui';

export const MODEL_URL = 'http://localhost:8080';
export const getAccessToken = (iframeRef: any) => {
  if (iframeRef.current) {
    const iframeContentWindow = iframeRef.current.contentWindow;

    if (iframeContentWindow) {
      const accessToken = window.localStorage.getItem('accessToken');
      return accessToken;
    }
  }
  return '';
};

const Model = () => {
  let {path} = useRouteMatch();

  return (
    <Box
      sx={{
        flex: 1,
        overflow: 'hidden',
      }}
    >
      <Router>
        <Switch>
          <Route path={`${path}/model-settings`} component={ModelSettings} />
          <Route path={`${path}/q-and-a`} component={QAndAPage} />
        </Switch>
      </Router>
    </Box>
  );
};

export default Model;
